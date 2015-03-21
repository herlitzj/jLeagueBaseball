#!/usr/bin/ruby

require 'mysql'


=begin
    con = Mysql.new 'localhost', 'root', 'waffles!'
    puts con.get_server_info
    rs = con.query 'SELECT VERSION()'
    puts rs.fetch_row    
    
rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
ensure
    con.close if con
=end

def sql_querie(num, vs, play)
	if num == 1
		begin
		    con = Mysql.new 'localhost', 'root', 'waffles!', 'jLeague'

		    vs = con.query("SELECT #{vs} FROM bloomquist_willie")
		    v_rows = vs.num_rows

		    play = con.query("SELECT #{play} FROM bloomquist_willie")
		    p_rows = play.num_rows
		    
		    #puts "There are #{n_rows} rows in the result set"
		    
		    v_arr = []
		    p_arr = []
		    play_hash = {}

		    v_rows.times do
		        v_arr.push(vs.fetch_row.join("\s"))
		    end
		    puts v_arr

		    p_rows.times do
		        p_arr.push(play.fetch_row.join("\s"))
		    end  
		    puts p_arr

		    counter = 0
		    v_arr.length.times do
		    	play_hash[v_arr[counter]] = p_arr[counter]
		    	counter +=1
		    end
		    puts play_hash
		    
		rescue Mysql::Error => e
		    puts e.errno
		    puts e.error
		    
		ensure
		    con.close if con
		end
	else
		puts "no data"

	end
end

sql_querie(1, 'vslh', 'play')
#sql_querie(1, 'vsrh')
#sql_querie(1, 'play')