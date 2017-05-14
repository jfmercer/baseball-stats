require "thor"
require_relative "baseball_statistics/parse_csv"

class BaseballStatistics < Thor
  desc "read MASTER BATTING", "read CSV files into memory"
  def read(master = nil, batting = nil)
    ParseCsv::read(master, batting)
  end
end
