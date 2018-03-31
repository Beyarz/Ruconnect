# # # # # # # #
#!/usr/bin/env ruby
# # # # # # #

# # # # # #
# Created March 31th 2018
# Copyright (c) 2018 Beyar N.
# File author: @devmaximilian
# # # #

# # #
# Name: daemon.rb
# #

raise '[!] Must be run as root' unless Process.uid == 0

begin
    `sudo gem install daemons`
    require 'daemons'
rescue
    puts "[!] Fatal error: Could not load daemons gem."
end

Daemons.run('client.rb')
puts "[*] Daemon state updated."