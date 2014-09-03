require 'csv'

class CsvMapper

  def initialize(csv_filename, map_object)
    @csv_filename = csv_filename
    @map_object = map_object
  end

  def load
    data_from_file.map { |csv_hash| @map_object.new(**csv_hash) }
  end

  private

  def data_from_file
    CSV.read(@csv_filename, headers: true).map do |csv_row|
      csv_row.to_hash.symbolize_keys
    end
  end
end
