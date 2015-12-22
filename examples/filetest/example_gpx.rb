#!/usr/bin/env ruby

# Add lib directory to search path
$: << File.dirname(__FILE__) + '/../../lib'

require 'csv'
require 'fitnesstrack'
require 'nokogiri'

class ArrayHash < Hash
  def initialize
    super {|hash, key| hash[key] = Array.new}
  end
end

module Tool
  # very simple example to list lap info from gpx file
  def self.go

    gpx = FitnessTrack::Gpx.read('gpx_in.xml')
    activities = gpx.activities

    activities.each do |act|
         puts "Id #{act.id}"

         puts "Sport #{act.sport}"
      
        laps = act.laps

        laps.each do |lap|
          puts "lap start: #{lap.start_time}"
          puts "lap total time: #{lap.total_time_seconds}"
          puts "lap distance meters: #{lap.distance_meters}"
          puts "lap distance miles: #{lap.distance_miles}"
          #puts "lap info: #{lap.info}"
    
=begin
		#track point functionality to be added here

          track_points = lap.track_points

          track_points.each do |tk|
            puts "index #{sb.track_points.index(tk)}"
            puts "tk time: #{tk.time}"
            puts "tk pos lat: #{tk.latitude}"
            puts "tk pos lon: #{tk.longitude}"
            puts "tk altitude meters: #{tk.altitude_meters}"
            puts "tk distance meters: #{tk.distance_meters}"
            puts "tk distance miles: #{tk.distance_miles}"
            #puts "lap info: #{sb.info}"
            #puts sb.attributes

          end
=end            
        end

    end

  end

end

Tool::go
