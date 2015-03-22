#required gems, files, etc.
require 'mysql'

#mysql calls
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

$dice = rand(999)

#game play
#inputs: dice roll, batter, catcher, pitcher
#outputs: play, fielder, runner rating, batter rating, 

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
	if $field != '' then $fielder = fielder($field) end
end

def fielder(field)
	case field
	when "1b" then
		$fielderName = $firstBase
		$fielderRating = single_query($firstBase, 'throw').join.to_i
	when "2b" then 
		$fielderName = $secondBase
		$fielderRating = single_query($secondBase, 'throw').join.to_i
	when "3b" then 
		$fielderName = $thirdBase
		$fielderRating = single_query($thirdBase, 'throw').join.to_i
	when "ss" then 
		$fielderName = $shortStop
		$fielderRating = single_query($shortStop, 'throw').join.to_i
	else puts "other fielder"
	end
	return $fielderName
	return $fielderRating
end

def runnerRating(runner)
	return single_query(runner, 'run').join.to_i
end

#commands to make it go
dice_roll

puts "batter is #{$batter}"
puts "pitcher is #{$pitcher}"
puts "play: #{$play}"
puts "fielder: #{$field}, #{$fielderName}, #{$fielderRating}"
puts "runner: #{runnerRating($secondRunner)}"