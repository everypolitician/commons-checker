class Report
  def initialize
    @reports = Hash.new { |h, k| h[k] = [] }
  end

  def add_item(level, category, filename, message)
    report = {
      level: level,
      category: category,
      filename: filename,
      message: message
    }
    @reports[filename].push report
  end

  def add_error(category, filename, message)
    add_item(:error, category, filename, message)
  end

  def add_warning(category, filename, message)
    add_item(:warning, category, filename, message)
  end

  def print
    @reports.keys.sort.each_with_index do |filename, i|
      puts if i > 0
      puts filename
      @reports[filename].each do |item|
        Kernel.print '* '
        puts item[:message].split("\n").join("\n  ")
      end
    end
  end

  def errored?
    @reports.each_value do |items|
        return true if items.any? { |item| item['level'] == :error }
    end
    return false
  end
end