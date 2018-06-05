require './etl/common/csv'

def save_bigfoot_classes
  save_csv 'cleaned/bigfoot_classinator.csv', bigfoot_classes
end

def bigfoot_classes
  read_csv('raw/bfro_reports_geocoded.csv')
    .map do |row|
      {
        :observed => row['observed'].to_s.strip,
        :classification => row['classification'].to_s.strip
      }
    end
    .find_all do |row|
      observed = row[:observed]
      classification = row[:classification]
      !observed.empty? && !classification.empty?
    end
end

save_bigfoot_classes
