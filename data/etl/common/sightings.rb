require './etl/common/common'

def all_sightings(start_year, start_month, end_year, end_month)
  ufo = ufo_sightings(start_year, start_month, end_year, end_month)
  bigfoot = bigfoot_sightings(start_year, start_month, end_year, end_month)
  merge_sightings ufo, bigfoot
end

def ufo_sightings(start_year, start_month, end_year, end_month)
  dates = ufo_sighting_dates(start_year, start_month, end_year, end_month)
  aggregate_sightings(dates, start_year, start_month, end_year, end_month)
end

def bigfoot_sightings(start_year, start_month, end_year, end_month)
  dates = bigfoot_sighting_dates(start_year, start_month, end_year, end_month)
  aggregate_sightings(dates, start_year, start_month, end_year, end_month)
end

def ufo_sighting_dates(start_year, start_month, end_year, end_month)
  sighting_dates 'raw/nuforc_reports.csv', 'date_time', start_year, start_month, end_year, end_month
end

def bigfoot_sighting_dates(start_year, start_month, end_year, end_month)
  sighting_dates 'raw/bfro_report_locations.csv', 'timestamp', start_year, start_month, end_year, end_month
end

def sighting_dates(filename, column, start_year, start_month, end_year, end_month)

  start_year_month = year_month_string(start_year, start_month)
  end_year_month = year_month_string(end_year, end_month)

  read_csv(filename)
    .map { |row| row[column].to_s.strip }
    .find_all { |date| !date.empty? }
    .find_all { |date| date[0...7] >= start_year_month && date[0...7] <= end_year_month }
    .sort
    .map { |date| DateTime.parse(date).strftime('%-m/1/%Y') }
end

def merge_sightings(ufo_sightings, bigfoot_sightings)
  ufo_sightings
    .zip(bigfoot_sightings)
    .map do |ufo, bigfoot|
      {
        :date => ufo[:date],
        :ufo_sightings => ufo[:sightings],
        :bigfoot_sightings => bigfoot[:sightings],
      }
    end
end

def aggregate_sightings(sighting_dates, start_year, start_month, end_year, end_month)
  all_the_dates = make_all_the_dates(start_year, start_month, end_year, end_month)
  fill_all_the_dates sighting_dates, all_the_dates
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

def year_month_string(year, month)
  "#{year}-#{"%02d" % month}"
end
