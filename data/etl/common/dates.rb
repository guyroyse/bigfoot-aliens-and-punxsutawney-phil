class YearMonth

  attr_reader :year, :month

  def initialize(year, month)
    @year, @month = year, month
  end

  def to_yyyy_mm
    "#{@year}-#{"%02d" % @month}"
  end

  def to_m_d_yyyy
    "#{@month}/1/#{@year}"
  end

end

class DateRanger

  def initialize(start_date, end_date)
    @start_date, @end_date = start_date, end_date
  end

  def dates

    current_year, current_month = @start_date.year, @start_date.month

    all_the_dates = []

    while current_year <= @end_date.year do
      while lte_end_date? current_year, current_month do
        all_the_dates << YearMonth.new(current_year, current_month).to_m_d_yyyy
        current_month += 1
      end
      current_month = 1
      current_year += 1
    end

    all_the_dates

  end

  private
    def lte_end_date?(year, month)
      (year != @end_date.year && month <= 12) || (year == @end_date.year && month <= @end_date.month)
    end

end
