require './etl/common/text_classifier'

shaper = UfoShaper.new
shaper.load
shaper.save 'cleaned/ufo_shaper.csv'