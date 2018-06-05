require './etl/common/csv'
require './etl/common/sightings'

def save_both_sightings_alltime
  save_csv 'cleaned/both_sightings_alltime.csv', both_sightings_alltime
end

def both_sightings_alltime
  all_sightings(1969, 1, 2017, 8)
end

save_both_sightings_alltime