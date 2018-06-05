require './etl/common/csv'
require './etl/common/sightings'

def save_bigfoot_sightings_pre_xfiles
  save_csv 'cleaned/bigfoot_sightings_pre_xfiles.csv', bigfoot_sightings_pre_xfiles
end

def bigfoot_sightings_pre_xfiles
  bigfoot_sightings(1969, 1, 1993, 9)
end

save_bigfoot_sightings_pre_xfiles
