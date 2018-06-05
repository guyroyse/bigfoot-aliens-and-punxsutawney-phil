require './etl/common/csv'
require './etl/common/sightings'

def save_ufo_sightings_pre_xfiles
  save_csv('cleaned/ufo_sightings_pre_xfiles.csv', ufo_sightings_pre_xfiles)
end

def ufo_sightings_pre_xfiles
  ufo_sightings(1969, 1, 1993, 9)
end

save_ufo_sightings_pre_xfiles
