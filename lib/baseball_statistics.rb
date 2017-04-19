require "thor"
require_relative "./process_csv"

class BaseballStatistics < Thor
  desc "hi NAME", "say hello"
  def hi(name)
    test(name)
  end
end
