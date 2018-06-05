require './common'
require './pre_xfiles_ufo'
require './pre_xfiles_bigfoot'

def save_all_sightings_pre_xfiles
  save_csv 'cleaned/both_sightings_pre_xfiles.csv', all_sightings_pre_xfiles
end

def all_sightings_pre_xfiles
  ufo_sightings_pre_xfiles
    .zip(bigfoot_sightings_pre_xfiles)
    .map do |ufo, bigfoot|
      {
        :date => ufo[:date],
        :ufo_sightings => ufo[:sightings],
        :bigfoot_sightings => bigfoot[:sightings],
      }
    end
end

save_all_sightings_pre_xfiles