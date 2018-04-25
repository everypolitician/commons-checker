require 'csv'
require 'set'

class Commons::Checker::Checks::MetadataCheck < Commons::Checker::Check
  EXPECTED_PRJ = 'GEOGCS["GCS_WGS_1984",DATUM["D_WGS_1984",SPHEROID["WGS_1984",6378137,298.257223563]],PRIMEM["Greenwich",0],UNIT["Degree",0.017453292519943295]]'

  def check_projection
    # We'd prefer to do it this way soon:
    # https://stackoverflow.com/questions/7751470/how-can-i-read-wkt-from-the-shapefile-prj
    # Issue #11 on gdal-ruby might be the answer
    Dir['**/*.prj'].each do |filename|
      prj = File.open( filename ).read

      if prj != EXPECTED_PRJ
        report.add_error :projection,
                         filename,
                         "Unexpected projection"
      end
    end
  end

  def check_encoding
    Dir['**/*.cpg'].each do |filename|
      encoding = File.open( filename ).read

      if encoding != 'UTF-8'
        report.add_error :encoding,
                         filename,
                         "Unexpected encoding (#{encoding})"
      end
    end
  end

  def check_csv_field_names
    relevant_field_names = Set.new %w{MS_FB MS_FB_PARE WIKIDATA}
    Dir['boundaries/**/*.csv'].each do |filename|
      field_names = CSV.open(filename).first
      relevant_field_names.each do |relevant_field_name|
        next if relevant_field_name == 'MS_FB_PARE' && filename.end_with?('/country.csv')

        unless field_names.include?(relevant_field_name)
          miscased_field_names = field_names.select { |field_name| field_name.upcase == relevant_field_name }
          if miscased_field_names.empty?
            report.add_warning :field_name_missing,
                               filename,
                               "CSV field missing: #{relevant_field_name}"
          else
            report.add_error :field_name_upcase,
                             filename,
                             "CSV field name should be uppercase: #{miscased_field_names.join(', ')}"
          end
        end
      end
    end


  end

end