require 'mysql'

#sql query
def play_query(player, dice, vsHand, var)
	if player != ''
		begin
		    con = Mysql.new 'localhost', 'root', 'waffles!', 'jLeague'

		    output = con.query("SELECT #{var} FROM #{player} where #{dice} <= #{vsHand} limit 1").fetch_row
		    
		rescue Mysql::Error => e
		    puts e.errno
		    puts e.error
		    
		ensure
		    con.close if con
		end
	else
		puts "no data"
	end
	return output
end

def single_query(player, data1)
	if player != ''
		begin
		    con = Mysql.new 'localhost', 'root', 'waffles!', 'jLeague'

		    output = con.query("SELECT #{data1} FROM #{player}").fetch_row
		    
		rescue Mysql::Error => e
		    puts e.errno
		    puts e.error
		    
		ensure
		    con.close if con
		end
	else
		puts "no data"
	end
	return output
end

#player placeholders
$catcher = 'navarro_dioner'
$firstBase = 'freeman_freddie'
$secondBase = 'kendrick_howard'
$thirdBase = 'longoria_evan'
$shortStop = 'reyes_jose'
$leftField = 'joyce_matthew'
$centerField = 'jones_adam'
$rightField = 'granderson_curtis'
$pitcher = 'minor_mike'

$batter = 'freeman_freddie'
$firstRunner = 'kendrick_howard'
$secondRunner = 'reyes_jose'
$thirdRunner = 'granderson_curtis'

$pitcherHand = single_query($pitcher, 'hand').join.to_s
$batterHand	= single_query($batter, 'hand').join.to_s

$dice = 138#rand(999)

#dice roll
def dice_roll
	case
	when $dice < 500 && $pitcherHand == 'left'
		$play = play_query($batter, $dice, 'vslh', 'play').join.to_s
		$field = play_query($batter, $dice, 'vslh', 'field_vslh').join.to_s
	when $dice < 500 && $pitcherHand == 'right'
		$play = play_query($batter, $dice, 'vslh', 'play').join.to_s
		$field = play_query($batter, $dice, 'vslh', 'field_vslh').join.to_s
	when $dice > 499 && $batterHand == 'left'
		$play = play_query($pitcher, $dice, 'vslh', 'play').join.to_s
		$field = play_query($pitcher, $dice, 'vslh', 'field_vslh').join.to_s
	when $dice > 499 && $batterHand == 'right'
		$play = play_query($pitcher, $dice, 'vslh', 'play').join.to_s
		$field = play_query($pitcher, $dice, 'vsrh', 'field_vsrh').join.to_s
	else
		puts "missing data"
	end
	#puts $batter, $batterHand, $pitcher, $pitcherHand, $dice
	#puts $play, $field
	#play_switch($play, $field)
end

#direction
$direction = ''
if $field == "1B" or $field == "2B" then $direction = "right" else $direction = "left" end

#bases
first = 1 #rand(2)
second = 0 # rand(2)
third = 0 #rand(2)
$bases = first.to_s + second.to_s + third.to_s




def hard_grounder(bases, direction, play)
	puts bases
	case bases
	when "000" then puts "Batter out at first."
	when "100" then 
		if play == "hg-"
			if $infielder_rating < 0 and rand(9) < $batter_rating
				puts "Runner out at second. Batter safe at first on slow throw from fielder."
			else puts "Runner out at second. Batter out at first."
			end
		elsif $hitAndRun == 1 and $runnerRating >= 2
			puts "Runner advances to second. Batter out at first."
		elsif $hitAndRun == 1 and $runnerRating <= 1
			puts "Runner out at second. Batter safe at first."				
		else puts "Runner out at second. Batter out at first."
		end
	#when "010" then
	#	if $direction == "left"
	#		puts "Batter out at first. Runner holds."
	#	else
	#		puts "Batter out at first. Runner advances to third."
	#	end
	#when "001" then puts "Batter out at first."
	#when "110" then puts "Runner on first out at second."
	#when "101" then puts "Defensive manager's choice. What to do?"
	#when "011" then puts "Batter out at first."
	#when "111" then puts "Runner on third scores."
	else puts "other play"
	end
end

def play_switch (play, field)
	case play
	when 'hg' || 'hg-'
		puts "hard grounder"
		hard_grounder($bases, $direction, play)
	else puts "other play"
	end
	puts $direction
end

dice_roll
play_switch($play, $field)

=begin
#bases
first = rand(2)
second = rand(2)
third = rand(2)
allBases = first.to_s + second.to_s + third.to_s
fielder = "3b"
direction = ''
if fielder == "1b" or fielder == "2b" then direction = "right" else direction = "left" end

puts allBases

hard_grounder(allBases, direction)
=end