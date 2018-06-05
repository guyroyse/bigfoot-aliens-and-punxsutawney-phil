require './etl/common/text_classifier'

classinator = BigfootClassinator.new
classinator.load
classinator.save 'cleaned/bigfoot_classinator.csv'
