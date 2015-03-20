#location array
location = "Great Lakes" #["Great Lakes", "Rocky Mountains", "Southern California", "North", "Eastern Seaboard", "Heartland", "Florida", "Northern California", "Deep South", "Southwest", "Pacific Northwest"]

#month array
month = "April" #["April", "May", "June", "July", "August", "September", "October"]

#time switch
time = rand(2)

#dice roll
dice = rand(99)

#select random month and location to test
puts location, month, time, dice

case time
	when 0
		if dice < 40 then puts "Warm"
		elsif dice < 78 then puts "Cool"
		else puts "Cold"
		end
	else
		if dice < 53 then puts "Cool"
		else puts "Cold"
	end
end
