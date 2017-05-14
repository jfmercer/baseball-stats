require "csv"

class ProcessCsv
  @@averages_2009 = {}
  @@averages_2010 = {}
  @@player_names = {}
  @@team_slugging_numbers = Array.new

  def self.read(master = nil, hitting = nil)
    read_master(master)
    read_hitting(hitting)
  end

  private
  def self.read_master(master)
    CSV.foreach(master, :headers => true) do |row|
      @player_id = row.fields[0]
      @first_name = row.fields[2]
      @last_name = row.fields[3]
      @@player_names[@player_id] = "#{@first_name} #{@last_name}"
    end
  end

  private
  def self.read_hitting(hitting)
    CSV.foreach(hitting, :headers => true) do |row|
      @player_id = row.fields[0]
      @year_id = row.fields[1].to_i
      @league = row.fields[2]
      @team_id = row.fields[3]
      @at_bats = row.fields[5].to_i
      @runs = row.fields[6].to_i
      @hits = row.fields[7].to_i
      @doubles = row.fields[8].to_i
      @triples = row.fields[9].to_i
      @home_runs = row.fields[10].to_i
      @rbi = row.fields[11].to_i

      self.build_averages(@player_id, @year_id, @at_bats, @hits)

      if self.is_oakland_2007(@year_id, @team_id, @at_bats)
        self.player_slugging_percentage(@hits, @doubles, @triples, @home_runs, @at_bats)
      end
    end

    self.print_oakland_average()
    self.most_improved_batting_average();
  end

  private
  def self.build_averages(player_id, year_id, at_bats, hits)
    if at_bats >= 200
      if year_id == 2009
        @@averages_2009[player_id] = batting_average(hits, at_bats)
      end
      if year_id == 2010
        @@averages_2010[player_id] = batting_average(hits, at_bats)
      end
    end
  end

  private
  def self.is_oakland_2007(year_id, team_id, at_bats)
   return year_id == 2007 && team_id == "OAK" && at_bats > 0
  end

  private
  def self.player_slugging_percentage(hits, doubles, triples, home_runs, at_bats)
    player_slugging_percentage = ((hits - doubles - triples - home_runs) \
      + (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bats.to_f
    @@team_slugging_numbers.push(player_slugging_percentage)
  end

  private
  def self.print_oakland_average()
    @avg = @@team_slugging_numbers.reduce(0, :+) / @@team_slugging_numbers.size
    puts "Oakland\'s slugging average in 2007 was #{@avg}"
  end

  private
  def self.most_improved_batting_average()
    @biggest_improvement = 0.0
    @most_improved_player = ""
    @@averages_2009.each do | player_id, avg |
      if @@averages_2010.key?(player_id)
        @improvement = @@averages_2010[player_id] - @@averages_2009[player_id]
        if @improvement > @biggest_improvement
          @biggest_improvement = @improvement
          @most_improved_player = @player_id
        end
      end
    end
    puts "Between 2009 and 2010, the player with the most improved batting" \
         " average was #{@@player_names[@most_improved_player]}. His batting" \
         "\naverage improved by #{@biggest_improvement * 100}%."
  end

  private
  def self.batting_average(hits, at_bats)
    return (hits.to_f / at_bats)
  end
end
