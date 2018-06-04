require 'csv'

rows = CSV.read('raw/bfro_reports_geocoded.csv', headers: true)
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

CSV.open('cleaned/bigfoot_classinator.csv', 'wb') do |csv|
  csv << rows.first.keys
  rows.each { |hash| csv << hash.values }
end
