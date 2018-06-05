require './common'
require './sightings_bigfoot'

def save_bigfoot_sightings
  save_csv 'cleaned/bigfoot_sightings_alltime.csv', bigfoot_sightings_alltime
end

def bigfoot_sightings_alltime
  bigfoot_sightings(1969, 1, 2017, 8)
end

save_bigfoot_sightings
