class Util
  class << self
    @@averages_2009 = {}
    @@averages_2010 = {}
    @@team_slugging_numbers = Array.new

    def build_averages(player_id, year_id, at_bats, hits)
      if at_bats >= 200
        if year_id == 2009
          @@averages_2009[player_id] = batting_average(hits, at_bats)
        end
        if year_id == 2010
          @@averages_2010[player_id] = batting_average(hits, at_bats)
        end
      end
    end

    def is_oakland_2007(year_id, team_id, at_bats)
      return year_id == 2007 && team_id == "OAK" && at_bats > 0
    end

    def player_slugging_percentage(hits, doubles, triples, home_runs, at_bats)
      player_slugging_percentage = ((hits - doubles - triples - home_runs) \
        + (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bats.to_f
      @@team_slugging_numbers.push(player_slugging_percentage)
    end

    def print_oakland_average()
      @avg = @@team_slugging_numbers.reduce(0, :+) / @@team_slugging_numbers.size
      puts "Oakland\'s slugging average in 2007 was #{@avg}"
    end

    def most_improved_batting_average(player_names)
      @biggest_improvement = 0.0
      @most_improved_player = ""
      @@averages_2009.each do | player_id, _avg |
        if @@averages_2010.key?(player_id)
          @improvement = @@averages_2010[player_id] - @@averages_2009[player_id]
          if @improvement > @biggest_improvement
            @biggest_improvement = @improvement
            @most_improved_player = @player_id
          end
        end
      end
      puts "Between 2009 and 2010, the player with the most improved batting" \
           " average was #{player_names[@most_improved_player]}. His batting" \
           "\naverage improved by #{@biggest_improvement * 100}%."
    end

    private
    def batting_average(hits, at_bats)
      return (hits.to_f / at_bats)
    end
  end
end
