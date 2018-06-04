require './common'
require './sightings'

def save_bigfoot_sightings_pre_xfiles
  save_csv 'cleaned/bigfoot_sightings_pre_xfiles.csv', bigfoot_sightings_pre_xfiles
end

def bigfoot_sightings_pre_xfiles
  aggregate_sightings(bigfoot_sighting_dates_pre_xfiles, 1969, 1, 1993, 9)
end

def bigfoot_sighting_dates_pre_xfiles
  read_csv('raw/bfro_report_locations.csv')
    .map { |row| row['timestamp'].to_s.strip }
    .find_all { |date| !date.empty? }
    .find_all { |date| date[0...7] >= '1969-01' && date[0...7] <= '1993-09' }
    .sort
    .map { |date| DateTime.parse(date).strftime('%-m/1/%Y') }
end

save_bigfoot_sightings_pre_xfiles
