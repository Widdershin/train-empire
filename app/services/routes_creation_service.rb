class RoutesCreationService
  ROUTES_CSV_FILE = "#{Rails.root}/data/routes.csv"
  def make
    CsvMapper.new(ROUTES_CSV_FILE, Route).load
  end
end
