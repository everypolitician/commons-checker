require 'json'
require 'open3'

class Commons::Checker::Checks::BoundaryCheck < Commons::Checker::Check
  def check_all_valid
    check_geometry_path = File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'bin', 'check_geometry')
    Open3.popen2(check_geometry_path) do |stdin, stdout, thread|
      JSON.load(stdout).each do |item|
        report.add_item item['level'].to_s, item['category'], item['filename'], item['message']
      end
    end
  end
end
