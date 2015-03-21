prompt "Tell me how many fingers I'm holding up."
answer = gets.chomp.to_i

if answer > 5 puts "Good guess."
else puts "Sorry, try again."
end