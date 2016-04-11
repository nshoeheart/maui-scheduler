# maui-scheduler
Tool to find possible course schedule combinations at UIowa using MAUI's public web services.

Given a set of course numbers at the University of Iowa, this tool will utilize the public web services available through MAUI to fetch and comb through all the possible schedule combinations for those courses. This version runs as a command line script using Ruby. To try it, you must have Ruby installed on your computer as well as the gem dependencies listed in the Gemfile. To get up and running:

1) Install Ruby on your local machine

2) Clone this repository to a directory on your local machine, and navigate to it

3) Enter 'gem install bundler'

4) Enter 'bundle install'

5) Enter 'ruby scheduler.rb'

6) Follow the script in your terminal window.


This repository will stop as-is with just the command line application. However, in the future I plan on creating a fully functional Rails application that will make selecting and viewing schedule combinations much easier through the use of a website.
