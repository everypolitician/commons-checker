require 'csv'

class  Commons::Checker::Checks::AttributeCheck < Commons::Checker::Check
  def check_ids_are_ascii
    relevant_field_names = Set.new %w{MS_FB MS_FB_PARE}
    Dir['boundaries/**/*.csv'].each do |filename|
      csv = CSV.open(filename)
      field_names = csv.first
      csv.each_with_index do |row, i|
        row = Hash[field_names.zip(row)]
        relevant_field_names.each do |field_name|
          if row[field_name].is_a?(String) && !row[field_name].ascii_only?
            report.add_error :csv_encoding,
                             filename,
                             "Field value for #{field_name} on row #{i+1} is not ASCII: #{row[field_name]}"
          end
        end
      end
    end
  end

  def check_wikidata_id_format
    Dir['boundaries/**/*.csv'].each do |filename|
      csv = CSV.open(filename)
      field_names = csv.first
      next unless field_names.include?('WIKIDATA')
      csv.each_with_index do |row, i|
        row = Hash[field_names.zip(row)]
        unless row['WIKIDATA'] =~ /^Q[1-9][0-9]*$/
          report.add_error :wikidata_id_format,
                           filename,
                           "Wikidata ID on row #{i+1} is wrong format: #{row['WIKIDATA']}"
        end
      end
    end
  end
end