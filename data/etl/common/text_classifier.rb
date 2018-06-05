require './etl/common/csv'

class TextClassifier

  attr_reader :rows

  def save(filename)
    save_csv filename, self.rows
  end

  protected
    def load_rows(filename, text_column, class_column)
      @rows = read_csv(filename)
        .map do |row|
          mapped_row = {}
          mapped_row[text_column] = row[text_column.to_s].to_s.strip
          mapped_row[class_column] = row[class_column.to_s].to_s.strip
          mapped_row
        end
        .find_all do |row|
          !row[text_column].empty? && !row[class_column].empty?
        end
    end

end

class BigfootClassinator < TextClassifier
  def load
    load_rows 'raw/bfro_reports_geocoded.csv', :observed, :classification
  end
end

class UfoShaper < TextClassifier
  def load
    load_rows 'raw/nuforc_reports.csv', :text, :shape
  end
end