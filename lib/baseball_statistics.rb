require "thor"
require_relative "./process_csv"

class BaseballStatistics < Thor
  desc "read MASTER BATTING", "read CSV files into memory"
  def read(master = nil, batting = nil)
    ProcessCsv.read(master, batting)
  end
end
