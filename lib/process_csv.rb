require "csv"

class ProcessCsv
  @@averages = {}
  @@player_names = {}

  # TODO: Replace with initialize()
  def self.read(master = nil, hitting = nil)
    puts "FML"
    read_master(master)
    read_hitting(hitting)
    # p @@player_names
  end

  private
  def self.read_master(master)
    puts "read_master called"
    CSV.foreach(master, :headers => true) do |row|
      player_id = row.fields[0]
      first_name = row.fields[2]
      last_name = row.fields[3]
      @@player_names[player_id] = "#{first_name} #{last_name}"
    end
  end

  private
  def self.read_hitting(hitting)
    puts "read_hitting called"
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

    self.print_hash(@@averages)
  end

  private
  def self.build_averages(player_id, year_id, at_bats, hits)
    # puts "build_averages called"
    if year_id == 2009
      # puts "year_id is #{year_id}"
      @@averages[player_id] = { 2009 => batting_average(hits, at_bats) }
      # @@averages[player_id] = "meh"
    end
    if year_id == 2010
      # puts "year_id is #{year_id}"
      # @@averages[player_id] = "meh"
      @@averages[player_id] = { 2010 => batting_average(hits, at_bats) }
    end
  end

# private
# def self.most_improved_batting_average(hash)
  
# end

  private
  def self.batting_average(hits, at_bats)
    if at_bats != 0
      return (hits / at_bats)
    end
    return 0
  end

  private
  def self.print_hash(hash)
    puts "print_hash called"
    hash.each do |key, value|
      puts "Player #{key} has #{value}"
    end
  end
end
