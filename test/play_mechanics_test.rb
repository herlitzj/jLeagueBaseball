
#batter info pulled from database
require 'mysql'

#db query to generate play hashes for pitcher and batter
def array_query(player, vsHand, play)
	if player != ''
		begin
		    con = Mysql.new 'localhost', 'root', 'waffles!', 'jLeague'

		    vs = con.query("SELECT #{vsHand} FROM #{player}")
		    v_rows = vs.num_rows

		    play = con.query("SELECT #{play} FROM #{player}")
		    p_rows = play.num_rows
		    
		    v_arr = []
		    p_arr = []
		    play_hash = {}

		    v_rows.times do
		        v_arr.push(vs.fetch_row.join("\s"))
		    end
		    #puts v_arr

		    p_rows.times do
		        p_arr.push(play.fetch_row.join("\s"))
		    end  
		    #puts p_arr
		    
		rescue Mysql::Error => e
		    puts e.errno
		    puts e.error
		    
		ensure
		    con.close if con
		end
		counter = 0
		v_arr.length.times do
		  	play_hash[v_arr[counter].to_i] = p_arr[counter].upcase
		   	counter +=1
		end
	else
		puts "no data"
	end
	return play_hash
end

#query for pulling single data variables for play mechanics
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
	puts output
end

#puts sql_query(1, 'vslh', 'play')


#placeholder values. Eventually these will be pulled from the databse
#batter_hash = {10 => "!", 67 => "E", 82 => "L_SS", 97 => "PARK", 128 => "1B_GCF", 129 => "3B_LCF", 226 => "HG_SS", 290 => "HG_2B", 322 => "HG_3B", 326 => "2B_LCF", 389 => "1B_LLF", 452 => "1B_LRF", 456 => "RG_3B", 457 => "HF_LF", 462 => "HB", 480 => "BB", 482 => "3B_CFW", 486 => "2B_LFL", 491 => "2B_LFW", 496 => "RG_SS", 498 => "HF_CF", 499 => "P_SS"}
#pitcher_hash = {514 => "PARK", 539 => "WP_PB", 564 => "OFR", 615 => "IFR", 616 => "HB", 624 => "SG_2B", 633 => "HF_CF", 651 => "1B_LCF", 658 => "HF_RF", 666=> "SG_SS", 673 => "HF_LF", 701 => "1B_GCF", 723 => "2B_RCF", 799 => "DF", 939 => "SO", 963 => "BB", 999 => "HG_2B"}

#random dice roll for 000-999. This is the way the IBL game functions so I am going with it.
dice_roll = 680 #rand(999)

#random numbers for bases. Eventually this will be generated and
#stored as the game progresses
first = 0 #rand(2)
second = 1 # rand(2)
third = 0 #rand(2)
$allBases = first.to_s + second.to_s + third.to_s

#placeholder pitcher/batter choice
batter = "bloomquist_willie"
pitcher = "bell_heath"

#an empty hash to store the chosen player's hash
play_hash = {}

#if dice_roll <500 use batter_hash
#if dice_roll >500 use pitcher_hash
if dice_roll < 500
	play_hash = array_query(batter, 'vslh', 'play_vslh')
else
	play_hash = array_query(pitcher, 'vslh', 'play_vslh')
end

#an empty array to store the play values
$play_array ||= []

play_hash.each do |value, play|
	if value >= dice_roll
		$play_array.push(play)
	end
end

#placeholder for fielders. Eventually will come from db
fielder = $play_array.first.split("_")[0] #"3b"
$direction = ''
if fielder == "1B" or fielder == "2B" then $direction = "right" else $direction = "left" end

#Play choice placeholders
$hitAndRun = rand(2)
$fielderIn = rand(2)
$runnerRating = rand(4)
$infielder_rating = -1
$batter_rating = 3

#hard grounder proc INCOMPLETE
def hard_grounder
	case $allBases
	when "000" then puts "Batter out at first."
	when "100" then 
		if $play_array.first.split("_")[0] == "HG-"
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
	when "010" then
		if $direction == "left"
			puts "Batter out at first. Runner holds."
		else
			puts "Batter out at first. Runner advances to third."
		end
	when "001" then puts "Batter out at first."
	when "110" then puts "Runner on first out at second."
	when "101" then puts "Defensive manager's choice. What to do?"
	when "011" then puts "Batter out at first."
	when "111" then puts "Runner on third scores."
	else puts "other play"
	end
end

#slow grounder proc INCOMPLETE
def slow_grounder
	case $allBases
	when "000" then puts "Batter out at first."
	when "100" then
		if $runnerRating >= 2
			puts "Batter out at first. Runner advances to second."
		else
			puts "Runner forced out at second. Batter safe at first."
		end
	when "010" then puts "Batter out at first. Runner advances to third."
	when "001" then puts "Batter out at first. Runner scores."
	when "110"
		if $runnerRating >= 2
			puts "Batter out at first. Runner advances to third."
		else
			puts "Runner forced out at second. Batter safe at first."
		end
	when "101" then
		if $runnerRating >= 2
			puts "Batter out at first. Runner on first advances to second and runner on third scores."
		else
			puts "Runner forced out at second. Batter safe at first."
		end
	when "011" then
		if $direction == "right"
			puts "Batter out at first. Runner on third scores. Runner on second advances to third."
		else
			puts "Batter out a first. Runner on third scores. Runner on second holds."
		end
	when "111" then
		if $runnerRating >= 2
			puts "Batter out at first. Runner on first advances to second, runner on second advances to third and runner on third scores."
		else
			puts "Runner forced out at second. Batter safe at first. Runner on second advances to third and runner on third scores."
		end
	else puts "other play"
	end
end



#________________PLAY MECHANICS START BELOW___________________________________


#output the final play value and dice roll and bases
if dice_roll < 500 then puts "Batter" else puts "Pitcher" end
puts dice_roll, $play_array.first, $allBases

#select play proc based on play_array values
case $play_array.first.split("_")[0]
	when "WILD" then puts "Wild Play"
	when "PARK" then puts "Park Effects"
	when "ERROR" then puts "Error"
	when "L" then puts "Line out"
	when "HG" then hard_grounder
	when "HG-" then hard_grounder
	when "RG" then puts "Routine grounder"
	when "SG" then puts slow_grounder
	when "1B" then puts "Single"
	when "2B" then puts "Double"
	when "3B" then puts "Triple"
	when "HR" then puts "HOMERUN!"
	when "HB" then puts "Hit by pitch"
	when "HF" then puts "High fly ball"
	when "BB" then puts "Base on balls"
	when "IFR" then puts "Infield Range"
	when "OFR" then puts "Outfield Range"
	when "P" then puts "Popout. Runners hold."
	when "FO" then puts "Foul out. Runners hold."
	when "WP_PB" then puts "Wild pitch or passed ball."
	when "DF" then puts "Deep fly ball"
	when "SO" then puts "Strike out"
	when "WT" then puts "Deep fly ball to warning track."
	when "LF" then puts "Long fly ball."
end