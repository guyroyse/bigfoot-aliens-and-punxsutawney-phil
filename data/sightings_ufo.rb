require './sightings'

def ufo_sightings(start_year, start_month, end_year, end_month)
  dates = ufo_sighting_dates(start_year, start_month, end_year, end_month)
  aggregate_sightings(dates, start_year, start_month, end_year, end_month)
end

def ufo_sighting_dates(start_year, start_month, end_year, end_month)

  start_year_month = "#{start_year}-#{"%02d" % start_month}"
  end_year_month = "#{end_year}-#{"%02d" % end_month}"

  read_csv('raw/nuforc_reports.csv')
    .map { |row| row['date_time'].to_s.strip }
    .find_all { |date| !date.empty? }
    .find_all { |date| date[0...7] >= start_year_month && date[0...7] <= end_year_month }
    .sort
    .map { |date| DateTime.parse(date).strftime('%-m/1/%Y') }
end