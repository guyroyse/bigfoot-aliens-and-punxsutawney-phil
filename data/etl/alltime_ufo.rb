require './etl/common/sightings'

start_date = YearMonth.new(1969, 1)
end_date = YearMonth.new(2017, 8)

sightings = UfoSightings.new(start_date, end_date)
sightings.load
sightings.save 'cleaned/ufo_sightings_alltime.csv'
