require './common'

def save_ufo_shapes
  save_csv 'cleaned/ufo_shaper.csv', ufo_shapes
end

def ufo_shapes
  read_csv('raw/nuforc_reports.csv')
    .map do |row|
      {
        :text => row['text'].to_s.strip,
        :shape => row['shape'].to_s.strip
      }
    end
    .find_all do |row|
      text = row[:text]
      shape = row[:shape]
      !text.empty? && !shape.empty?
    end
end

save_ufo_shapes
