require 'mysql'

#location
location = "Boston"

#region array
#region = "Great Lakes" #["Great Lakes", "Rocky Mountains", "Southern California", "North", "Eastern Seaboard", "Heartland", "Florida", "Northern California", "Deep South", "Southwest", "Pacific Northwest"]

#month array
month = "May" #["April", "May", "June", "July", "August", "September", "October"]

#time switch
time = "Day"

#test hashes (these will eventually pull from database)
#day_temp = {3 => "Hot", 66 => "Warm", 97 => "Cool", 99 => "Cold"}
#night_temp = {0 => "Hot", 22 => "Warm", 94 => "Cool", 99 => "Cold"}
#sky = {23 => "Clear", 57 => "Partly Cloudy", 99 => "Cloudy"}
#precipitation = {14 => "Thunderstorms", 41 => "Showers", 46 => "Fog", 99 => "None"}

#dice roll
def dice
	rand(99)
end

#select random month and location to test
#puts temp_dice, precip_dice, sky_dice
#puts

=begin
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
	roll = dice
	if value >= roll
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
=end

#sql query
def wind_query(column, table, location, roll)
	if location != ''
		begin
		    con = Mysql.new 'localhost', 'root', 'waffles!', 'jLeague'

		    output = con.query("SELECT #{column} FROM #{table} WHERE wind >= #{roll} AND location = '#{location}'").fetch_row
		    
		rescue Mysql::Error => e
		    puts e.errno
		    puts e.error
		    
		ensure
		    con.close if con
		end
	else
		puts "no data"
	end
	output
end

def weather_query(column, table, category1, month, roll)
	if column != ''
		begin
		    con = Mysql.new 'localhost', 'root', 'waffles!', 'jLeague'

		    output = con.query("SELECT #{column} FROM #{table} WHERE #{month} >= #{roll} AND category1 = '#{category1}'").fetch_row
		    
		rescue Mysql::Error => e
		    puts e.errno
		    puts e.error
		    
		ensure
		    con.close if con
		end
	else
		puts "no data"
	end
	output
end

#puts "Location: #{location}, Date: #{month}, Time: #{time}"
wind = wind_query('direction', 'wind', location, dice).join("")
temp = weather_query('category2', 'weather', time.downcase, month.downcase, dice)
sky = weather_query('category2', 'weather', 'sky', month.downcase, dice)
precip = weather_query('category2', 'weather', 'precip', month.downcase, dice)
puts location.capitalize, month.capitalize, time, temp.join("").capitalize, sky.join("").split("_").join(" ").capitalize 
puts precip.join("").capitalize if sky.join("").split("_").join(" ").capitalize == "Cloudy"

