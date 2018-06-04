require './common'
require './monthly_sightings'

def save_bigfoot_sightings
  save_csv 'cleaned/bigfoot_monthly_sightings.csv', bigfoot_sightings
end

def bigfoot_sightings
  aggregate_sightings(bigfoot_sighting_dates, 1969, 1, 2017, 8)
end

def bigfoot_sighting_dates
  read_csv('raw/bfro_report_locations.csv')
    .map { |row| row['timestamp'].to_s.strip }
    .find_all { |date| !date.empty? }
    .find_all { |date| date[0...7] >= '1969-01' && date[0...7] <= '2017-08' }
    .sort
    .map { |date| DateTime.parse(date).strftime('%-m/1/%Y') }
end

save_bigfoot_sightings
