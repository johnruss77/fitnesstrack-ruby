
require 'time'
require 'active_support/core_ext/string/inflections.rb'

module FitnessTrack
  module Tcx
    # Represents a lap of an activity
    class TrackPoint

      def self.create(node, lap)
          self.new(node, lap)
      end
    
      attr_reader  :time, :latitude, :longitude, :altitude_meters, :distance_meters,
      :lap, :node

      # Takes a Nokogiri XML node and a Lap object
      def initialize(node, lap)
       
        @node = node
        @activity = lap
      
        @time = Time.parse(@node.at_xpath('Time').content).to_s
        @latitude = @node.at_xpath('Position/LatitudeDegrees').content
        @longitude = @node.at_xpath('Position/LongitudeDegrees').content
        @altitude_meters = @node.at_xpath('AltitudeMeters').content
        @distance_meters = @node.at_xpath('DistanceMeters').content

      end

      def distance_miles
        @distance_meters.to_f / 1609.35
      end

    end

  end

end