class Commons::Checker::Check
  attr_accessor :report

  def initialize(report)
    @report = report
  end

  def shapefile_names
    ['boundaries/country/country.shp']
  end
end