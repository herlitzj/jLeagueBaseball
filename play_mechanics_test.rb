#THIS FILE IS DEPRECATED - ALL MECHANICS MOVED TO play_mechanics_test.rb

#batter info pulled from database
require 'mysql'

batter = "bloomquist_willie"
pitcher = "bell_heath"

def sql_query(player, vsHand, play)
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


#puts sql_query(1, 'vslh', 'play')


#placeholder values. Eventually these will be pulled from the databse
#batter_hash = {10 => "!", 67 => "E", 82 => "L_SS", 97 => "PARK", 128 => "1B_GCF", 129 => "3B_LCF", 226 => "HG_SS", 290 => "HG_2B", 322 => "HG_3B", 326 => "2B_LCF", 389 => "1B_LLF", 452 => "1B_LRF", 456 => "RG_3B", 457 => "HF_LF", 462 => "HB", 480 => "BB", 482 => "3B_CFW", 486 => "2B_LFL", 491 => "2B_LFW", 496 => "RG_SS", 498 => "HF_CF", 499 => "P_SS"}
#pitcher_hash = {514 => "PARK", 539 => "WP_PB", 564 => "OFR", 615 => "IFR", 616 => "HB", 624 => "SG_2B", 633 => "HF_CF", 651 => "1B_LCF", 658 => "HF_RF", 666=> "SG_SS", 673 => "HF_LF", 701 => "1B_GCF", 723 => "2B_RCF", 799 => "DF", 939 => "SO", 963 => "BB", 999 => "HG_2B"}

#random dice roll for 000-999. This is the way the IBL game functions so I am going with it.
dice_roll = rand(999)

#an empty hash to store the chosen hash
play_hash = {}

#if dice_roll <500 use batter_hash
#if dice_roll >500 use pitcher_hash
if dice_roll < 500
	play_hash = sql_query(batter, 'vslh', 'play_vslh')
else
	play_hash = sql_query(pitcher, 'vslh', 'play_vslh')
end

#an empty array to store the play values
play_array ||= []

play_hash.each do |value, play|
	if value >= dice_roll
		play_array.push(play)
	end
end

#output the final play value and dice roll
if dice_roll < 500 then puts "Batter" else puts "Pitcher" end
puts dice_roll, play_array.first

case play_array.first
	when "!" then puts "Wild Play"
	when "PARK" then puts "Special park Play"
	when "HG_SS" then puts "Hard grounder to short stop"
	when "RG_SS" then puts "Routine grounder to the short stop"
	when "RG_1B" then puts "routine grounder to the first baseman"
	when "1B_SS" then puts "Single to the short stop"
	when "HR" then puts "HOMERUN!"
	when "HB" then puts "Hot ball"
	when "3B" then puts "Triple"
end