def aggregate_sightings(sighting_dates, start_year, start_month, end_year, end_month)
  all_the_dates = make_all_the_dates(start_year, start_month, end_year, end_month)
  aggregated_sightings = fill_all_the_dates(sighting_dates, all_the_dates)
  aggregated_sightings
end

def make_all_the_dates(start_year, start_month, end_year, end_month)

  current_year = start_year
  current_month = start_month

  all_the_dates = []

  while current_year <= end_year do
    while (current_year != end_year && current_month <= 12) || (current_year == end_year && current_month <= end_month) do
      all_the_dates << "#{current_month}/1/#{current_year}"
      current_month += 1
    end
    current_month = 1
    current_year += 1
  end

  all_the_dates

end

def fill_all_the_dates(sighting_dates, all_the_dates)

  aggregated_sightings = all_the_dates.map { |date| { :date => date, :sightings => 0 } }

  sighting_dates.each do |date|
    index = aggregated_sightings.find_index { |row| row[:date] == date }
    aggregated_sightings[index][:sightings] += 1
  end

  aggregated_sightings
end
