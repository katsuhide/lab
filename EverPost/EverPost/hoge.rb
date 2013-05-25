# encoding: utf-8
puts "Test start"
sleep 5
puts "Create thread"

t = Thread.new do
  puts "Start thread"
  sleep 10 
  puts "End thread"
end

puts "Waiting for the thread to complete"
t.join

puts "Test compleated"
