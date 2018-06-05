require './etl/common/csv'
require './etl/common/sightings'

def save_all_sightings_pre_xfiles
  save_csv 'cleaned/both_sightings_pre_xfiles.csv', all_sightings_pre_xfiles
end

def all_sightings_pre_xfiles
  all_sightings(1969, 1, 1993, 9)
end

save_all_sightings_pre_xfiles