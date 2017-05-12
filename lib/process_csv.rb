require "csv"

class ProcessCsv
  @@averages_2009 = {}
  @@averages_2010 = {}
  @@player_names = {}

  # TODO: Replace with initialize()
  def self.read(master = nil, hitting = nil)
    # puts "FML"
    read_master(master)
    read_hitting(hitting)
    # p @@player_names
  end

  private
  def self.read_master(master)
    # puts "read_master called"
    CSV.foreach(master, :headers => true) do |row|
      player_id = row.fields[0]
      first_name = row.fields[2]
      last_name = row.fields[3]
      @@player_names[player_id] = "#{first_name} #{last_name}"
    end
  end

  private
  def self.read_hitting(hitting)
    # puts "read_hitting called"
    CSV.foreach(hitting, :headers => true) do |row|
      player_id = row.fields[0]
      year_id = row.fields[1].to_i
      league = row.fields[2]
      team_id = row.fields[3]
      at_bats = row.fields[5].to_i
      runs = row.fields[6].to_i
      hits = row.fields[7].to_i
      doubles = row.fields[8].to_i
      triples = row.fields[9].to_i
      home_runs = row.fields[10].to_i
      rbi = row.fields[11].to_i

      self.build_averages(player_id, year_id, at_bats, hits)
    end

    # self.print_hash(@@averages_2009)
    # self.print_hash(@@averages_2010)
    # puts @@averages_2009["abreubo01"]
    # puts @@averages_2010["abreubo01"]

    self.most_improved_batting_average();
  end

  private
  def self.build_averages(player_id, year_id, at_bats, hits)
    # puts "build_averages called"
    if at_bats >= 200
      if year_id == 2009
        # puts "year_id is #{year_id}"
        # @@averages[player_id] = "meh"
        @@averages_2009[player_id] = batting_average(hits, at_bats)
      end
      if year_id == 2010
        @@averages_2010[player_id] = batting_average(hits, at_bats)
      end
    end
  end

  private
  def self.most_improved_batting_average()
    biggest_improvement = 0.0
    most_improved_player = ""
    @@averages_2009.each do | player_id, avg |
      if @@averages_2010.key?(player_id)
        improvement = @@averages_2010[player_id] - @@averages_2009[player_id]
        if improvement > biggest_improvement
          biggest_improvement = improvement
          most_improved_player = player_id
        end
      end
    end
    puts "Between 2009 and 2010, the most player with the most improved batting"
    puts "average was #{@@player_names[most_improved_player]}. His batting"
    puts "average improved by #{biggest_improvement * 100}%."
  end

  private
  def self.batting_average(hits, at_bats)
    # avg = hits.to_f / at_bats
    # puts "Hits: #{hits} At_Bats: #{at_bats} Avg: #{avg}"
    return (hits.to_f / at_bats)
    # return avg
  end

# DEBUG METHOD TODO: DELETE
  private
  def self.print_hash(hash)
    puts "print_hash called"
    hash.each do |key, value|
      puts "Player #{key} has #{value}"
    end
  end
end
