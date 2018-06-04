require './common'
require './ufo_monthly_sightings'
require './bigfoot_monthly_sightings'

def save_all_sightings
  save_csv 'cleaned/all_monthly_sightings.csv', all_sightings
end

def all_sightings
  merge_sightings(ufo_sightings, bigfoot_sightings)
end

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

save_all_sightings