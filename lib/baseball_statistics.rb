require "thor"

class BaseballStatistics < Thor
  desc "hi NAME", "say hello"
  def hi(name)
    puts "Hello #{name}!"
  end
end
