#location array
location = "Great Lakes" #["Great Lakes", "Rocky Mountains", "Southern California", "North", "Eastern Seaboard", "Heartland", "Florida", "Northern California", "Deep South", "Southwest", "Pacific Northwest"]

#month array
month = "May" #["April", "May", "June", "July", "August", "September", "October"]

#time switch
time = "Day"

#test hashes (these will eventually pull from database)
day_temp = {3 => "Hot", 66 => "Warm", 97 => "Cool", 99 => "Cold"}
night_temp = {0 => "Hot", 22 => "Warm", 94 => "Cool", 99 => "Cold"}
sky = {23 => "Clear", 57 => "Partly Cloudy", 99 => "Cloudy"}
precipitation = {14 => "Thunderstorms", 41 => "Showers", 46 => "Fog", 99 => "None"}

#dice roll
temp_dice = rand(99)
precip_dice = rand(99)
sky_dice = rand(99)

#select random month and location to test
puts temp_dice, precip_dice, sky_dice
puts

#choose between daytime and night time temp hashes
temp_hash = {}

if time == "Day"
	temp_hash = day_temp
else
	temp_hash = night_temp
end

#set empty arrays to accept values
temp_array = []
sky_array = []
precipitation_array = []

#fill arrays based on dice rolls
temp_hash.each do |value, temp|
	if value >= temp_dice
		temp_array.push(temp)
	end
end

sky.each do |value, sky|
	if value >= sky_dice
		sky_array.push(sky)
	end
end

precipitation.each do |value, precip|
	if value >= precip_dice
		precipitation_array.push(precip)
	end
end

puts location, month, time, temp_array.first, sky_array.first 
puts precipitation_array.first if sky_array.first == "Cloudy"