#!/usr/bin/ruby

require 'mysql'

def array_query(player, dice, vsHand, play)
	if player != ''
		begin
		    con = Mysql.new 'localhost', 'root', 'waffles!', 'jLeague'

		    #vs = con.query("SELECT #{vsHand} FROM #{player} limit 1")
		    #v_rows = vs.num_rows

		    play = con.query("SELECT #{play} FROM #{player} where #{dice} <= #{vsHand} limit 1").fetch_row
		    #p_rows = play.num_rows
		    
		   # v_arr = []
		    #p_arr = []
		    #play_hash = {}

		    #v_rows.times do
		    #    v_arr.push(vs.fetch_row.join("\s"))
		    #end
		    #puts v_arr

		    #p_rows.times do
		    #    p_arr.push(play.fetch_row.join("\s"))
		    #end  
		    #puts p_arr
		    
		rescue Mysql::Error => e
		    puts e.errno
		    puts e.error
		    
		ensure
		    con.close if con
		end
		#counter = 0
		#v_arr.length.times do
		#  	play_hash[v_arr[counter].to_i] = p_arr[counter].upcase
		#   	counter +=1
		#end
	else
		puts "no data"
	end
	return play
end

dice = 100
puts array_query('bloomquist_willie', dice, 'vslh', 'play_vslh')