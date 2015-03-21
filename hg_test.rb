def hg(bases, direction)
	#bases = bases
	case bases
	when "000" then puts "Batter out at first."
	when "100" then puts "Runner out at second."
	when "010" then
		if direction == "l"
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



#bases
first = rand(2)
second = rand(2)
third = rand(2)
allBases = first.to_s + second.to_s + third.to_s
direction = "r"

puts allBases

hg(allBases, direction)