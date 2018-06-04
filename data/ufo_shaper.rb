require 'csv'

rows = CSV.read('raw/nuforc_reports.csv', headers: true)
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

CSV.open('cleaned/ufo_shaper.csv', 'wb') do |csv|
  csv << rows.first.keys
  rows.each { |hash| csv << hash.values }
end
