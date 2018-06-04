require './common'
require './sightings'

def save_ufo_sightings_pre_xfiles
  save_csv('cleaned/ufo_sightings_pre_xfiles.csv', ufo_sightings_pre_xfiles)
end

def ufo_sightings_pre_xfiles
  aggregate_sightings(ufo_sighting_dates_pre_xfiles, 1969, 1, 1993, 9)
end

def ufo_sighting_dates_pre_xfiles
  read_csv('raw/nuforc_reports.csv')
    .map { |row| row['date_time'].to_s.strip }
    .find_all { |date| !date.empty? }
    .find_all { |date| date[0...7] >= '1969-01' && date[0...7] <= '1993-09' }
    .sort
    .map { |date| DateTime.parse(date).strftime('%-m/1/%Y') }
end

save_ufo_sightings_pre_xfiles
