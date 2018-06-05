require './etl/common/dates'
require './etl/common/csv'

class SightingsBase

  attr_reader :sightings

  def initialize(start_date, end_date)
    @start_date, @end_date = start_date, end_date
  end

  def save(filename)
    save_csv filename, self.sightings
  end

end

class Sightings < SightingsBase

  protected
    def load_sightings(filename, column_name)
      dates = load_sighting_dates(filename, column_name)
      @sightings = aggregate_sightings(dates)
    end

  private
    def load_sighting_dates(filename, column)
      read_csv(filename)
        .map { |row| row[column].to_s.strip }
        .find_all { |date| !date.empty? }
        .find_all { |date| date[0...7] >= @start_date.to_yyyy_mm && date[0...7] <= @end_date.to_yyyy_mm }
        .sort
        .map { |date| DateTime.parse(date).strftime('%-m/1/%Y') }
    end

    def aggregate_sightings(sighting_dates)
      DateRanger.new(@start_date, @end_date).dates
        .map do |date|
          {
            :date => date,
            :sightings => sighting_dates.count(date)
          }
        end
    end

end

class BigfootSightings < Sightings
  def load
    load_sightings 'raw/bfro_report_locations.csv', 'timestamp'
  end
end

class UfoSightings < Sightings
  def load
    load_sightings 'raw/nuforc_reports.csv', 'date_time'
  end
end

class AllSightings < SightingsBase

  def load
    bigfoot_sightings = BigfootSightings.new(@start_date, @end_date)
    ufo_sightings = UfoSightings.new(@start_date, @end_date)

    bigfoot_sightings.load
    ufo_sightings.load

    @sightings = merge_sightings(ufo_sightings.sightings, bigfoot_sightings.sightings)
  end

  private
    def merge_sightings(ufo_sightings, bigfoot_sightings)
      ufo_sightings
        .zip(bigfoot_sightings)
        .map do |ufo, bigfoot|
          {
            :date => ufo[:date],
            :ufo_sightings => ufo[:sightings],
            :bigfoot_sightings => bigfoot[:sightings],
          }
        end
    end

end
