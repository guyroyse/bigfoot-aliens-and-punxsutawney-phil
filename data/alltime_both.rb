require './common'
require './alltime_ufo'
require './alltime_bigfoot'

def save_all_sightings
  save_csv 'cleaned/both_sightings_alltime.csv', all_sightings
end

def all_sightings
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

save_all_sightings