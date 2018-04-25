class Commons
  class Checker
    class Checks

    end
  end
end

require 'commons/checker/report'
require 'commons/checker/check'
require 'commons/checker/checks/boundary_check'

class Commons::Checker
  def run
    report = Report.new
    checks = get_checks
    checks.each do |check|
      check = check.new(report)
      get_check_method_names(check).each do |method_name|
        check.send(method_name)
      end
    end

    report.print

    exit(1) if report.errored?
  end

  def get_checks
    Commons::Checker::Checks.constants \
      .map { |s| Commons::Checker::Checks.const_get(s) }
      .select { |c| c.instance_of?(Class) && c < Commons::Checker::Check }
  end

  def get_check_method_names(check)
    check.methods.select { |name| name.to_s.start_with? 'check_'}
  end
end

