require './sightings_ufo'
require './sightings_bigfoot'

def all_sightings(start_year, start_month, end_year, end_month)
  ufo_sightings(start_year, start_month, end_year, end_month)
    .zip(bigfoot_sightings(start_year, start_month, end_year, end_month))
    .map do |ufo, bigfoot|
      {
        :date => ufo[:date],
        :ufo_sightings => ufo[:sightings],
        :bigfoot_sightings => bigfoot[:sightings],
      }
    end
end
