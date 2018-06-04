require 'csv'

def save_csv(filename, data)
  CSV.open(filename, 'wb') do |csv|
    csv << data.first.keys
    data.each { |hash| csv << hash.values }
  end
end

def read_csv(filename)
  CSV.read filename, headers: true
end

