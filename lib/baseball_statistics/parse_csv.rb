require "csv"
require_relative "util"

class ParseCsv
  @@player_names = {}

  def self.read(master = nil, hitting = nil)
    read_master(master)
    read_hitting(hitting)
  end

  def self.read_master(master)
    CSV.foreach(master, :headers => true) do |row|
      @player_id = row.fields[0]
      @first_name = row.fields[2]
      @last_name = row.fields[3]
      @@player_names[@player_id] = "#{@first_name} #{@last_name}"
    end
  end

  def self.read_hitting(hitting)
    CSV.foreach(hitting, :headers => true) do |row|
      @player_id = row.fields[0]
      @year_id = row.fields[1].to_i
      @team_id = row.fields[3]
      @at_bats = row.fields[5].to_i
      @hits = row.fields[7].to_i
      @doubles = row.fields[8].to_i
      @triples = row.fields[9].to_i
      @home_runs = row.fields[10].to_i

      Util.build_averages(@player_id, @year_id, @at_bats, @hits)

      if Util.is_oakland_2007(@year_id, @team_id, @at_bats)
        Util.player_slugging_percentage(@hits, @doubles, @triples, @home_runs, @at_bats)
      end
    end

    Util.print_oakland_average()
    Util.most_improved_batting_average(@@player_names);
  end
end
