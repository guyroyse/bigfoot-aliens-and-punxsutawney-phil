require './common'
require './sightings'

def save_ufo_sightings
  save_csv('cleaned/ufo_sightings_alltime.csv', ufo_sightings)
end

def ufo_sightings
  aggregate_sightings(ufo_sighting_dates, 1969, 1, 2017, 8)
end

def ufo_sighting_dates
  read_csv('raw/nuforc_reports.csv')
    .map { |row| row['date_time'].to_s.strip }
    .find_all { |date| !date.empty? }
    .find_all { |date| date[0...7] >= '1969-01' && date[0...7] <= '2017-08' }
    .sort
    .map { |date| DateTime.parse(date).strftime('%-m/1/%Y') }
end

save_ufo_sightings
