#placeholder values. Eventually these will be pulled from the databse
batter_hash = {17 => "!", 22 => "PARK", 78 => "HG", 125 => "RG_SS", 187 => "RG_1B", 220 => "1B_SS", 305 => "HR", 325 => "HB", 499 => "3B"}
pitcher_hash = {517 => "!", 522 => "PARK", 543 => "HG", 580 => "RG_SS", 637 => "RG_1B", 674 => "1B_SS", 714 => "HR", 830 => "HB", 999 => "3B"}

#random dice roll for 000-999. This is the way the IBL game functions so I am going with it.
dice_roll = rand(999)

#an empty hash to store the chosen hash
play_hash = {}

#if dice_roll <500 use batter_hash
#if dice_roll >500 use pitcher_hash
if dice_roll < 500
	play_hash = batter_hash
else
	play_hash = pitcher_hash
end

#an empty array to store the play values
play_array = []

play_hash.each do |value, play|
	if value > dice_roll
		play_array.push(play)
	end
end

#output the final play value and dice roll
puts play_array.first, dice_roll
