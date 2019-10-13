# # # # # # # #
#!/usr/bin/env ruby
# # # # # # #

# # # # # #
# Created Mars 29th 2018
# Copyright (c) 2018 Beyar.
# # # #

# # #
# Name: host.rb
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
require "ipaddr"
require "net/http"

# Get details
standardPort = 4434
ending = false
#public = Net::HTTP.get(URI("https://api.ipify.org"))
iip_ipadress = Socket.getifaddrs
iip_ipadress.each do |iip_interface|
	if iip_interface.addr
		if iip_interface.addr.ipv4?
			#puts"#{iip_interface.name}#{White} has address #{iip_interface.addr.ip_address}#{White}"
			@interface = myinterface = iip_interface.name
			#@private = myipadress = iip_interface.addr.ip_address
			@private = "localhost"
		end
	end
end

recon = []
connect_count = 0
count = 0
loop = true
while loop == true
	
	# Details
	puts "[!] Starting receiver!\n"
	inbound = TCPServer.new standardPort
	puts "[+] Receiver started!"
	begin
		print "\n[!] Command: "
		command = gets.chomp
		if command == "quit" || command == "exit"
			loop = false
		elsif command == "cls"
			Sys.cmd("clear")
		end
		rescue Interrupt
		o = "Shutting down host."
		break
	end
	puts
	
	# Accept, send & close
	begin
		ending = false
		while ending != true
			randPort = (2000..65535).to_a.sample
			id = (0..100).to_a.sample
			incoming = inbound.accept
			puts "\n[!] New client!"
			incoming.puts @private
			recon.push(@private)
			puts "[!] Directed to host: #{@private}"
			incoming.puts randPort
			recon.push(randPort)
			puts "[!] Directed to port: #{randPort}"
			incoming.puts command
			puts "[!] Sent command: #{'"'+command+'"'}"
			incoming.puts id
			puts "[!] Identified as ID: #{id}"
			incoming.close
		end
		rescue Interrupt
		ending = true
		inbound.close
		puts "[-] Shutting down receiver!"
	end

	# Connect, commend & close
	finish = false
	while finish != true
		puts "\n[+] Starting connection ##{connect_count}..."
		puts "[!] Connecting to #{recon[count]} #{recon[count+1]}"
		begin
			inbound = TCPSocket.new recon[count], recon[count+1]
			iterating = true
			while iterating
				incoming = inbound.gets
				if incoming == nil
					iterating = false
				else
					puts "[!] Received data ID #{incoming}"
				end
			end
			inbound.close
			count += 2
			connect_count += 1
			if count == recon.count
				finish = true
			end
			rescue SocketError
			finish = true
			Sys.cls
			puts "No sessions received."
		end
	end
	
	inbound.close
	puts
	
end
puts "\n#{o}"
