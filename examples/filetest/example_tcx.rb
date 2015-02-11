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
  # very simple example to list lap info from tcx file
  def self.go
    tcx = FitnessTrack::Tcx.read('tcx_in.xml')
    activities = tcx.activities

    activities.each do |act|
      #puts act
      puts "Id #{act.id}"
      puts "Sport #{act.sport}"
      
      laps = act.laps

      laps.each do |lap|
        puts "lap start: #{lap.start_time}"
        puts "lap total time: #{lap.total_time_seconds}"
        puts "lap distance meters: #{lap.distance_meters}"
        puts "lap distance miles: #{lap.distance_miles}"
        #puts "lap info: #{sb.info}"
        #puts sb.attributes
=begin        
        track_points = lap.track_points

        track_points.each do |tk|
          puts "trk time: #{tk.time}"
          puts "trk pos lat: #{tk.latitude}"
          puts "trk pos lon: #{tk.longitude}"
          puts "trk altitude meters: #{tk.altitude_meters}"
          puts "trk distance meters: #{tk.distance_meters}"
          #puts "lap info: #{sb.info}"
          #puts sb.attributes

        end  
=end        

        end

    end
 
  end

end

Tool::go
