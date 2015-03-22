require 'mysql'

def single_query(player, data1)
	if player != ''
		begin
		    con = Mysql.new 'localhost', 'root', 'waffles!', 'jLeague'

		    return1 = con.query("SELECT #{data1} FROM #{player}").fetch_row
		    
		rescue Mysql::Error => e
		    puts e.errno
		    puts e.error
		    
		ensure
		    con.close if con
		end
	else
		puts "no data"
	end
	puts return1
end

single_query("bloomquist_willie", "steal")