require './etl/common/csv'
require './etl/common/sightings'

def save_ufo_sightings
  save_csv('cleaned/ufo_sightings_alltime.csv', ufo_sightings_alltimes)
end

def ufo_sightings_alltimes
  ufo_sightings(1969, 1, 2017, 8)
end

save_ufo_sightings
