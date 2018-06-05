require './sightings'

def bigfoot_sightings(start_year, start_month, end_year, end_month)
  dates = bigfoot_sighting_dates(start_year, start_month, end_year, end_month)
  aggregate_sightings(dates, start_year, start_month, end_year, end_month)
end

def bigfoot_sighting_dates(start_year, start_month, end_year, end_month)

  start_year_month = "#{start_year}-#{"%02d" % start_month}"
  end_year_month = "#{end_year}-#{"%02d" % end_month}"

  read_csv('raw/bfro_report_locations.csv')
    .map { |row| row['timestamp'].to_s.strip }
    .find_all { |date| !date.empty? }
    .find_all { |date| date[0...7] >= start_year_month && date[0...7] <= end_year_month }
    .sort
    .map { |date| DateTime.parse(date).strftime('%-m/1/%Y') }
end
