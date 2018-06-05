require './etl/common/sightings'

start_date = YearMonth.new(1969, 1)
end_date = YearMonth.new(1993, 9)

sightings = UfoSightings.new(start_date, end_date)
sightings.load
sightings.save 'cleaned/ufo_sightings_pre_xfiles.csv'
