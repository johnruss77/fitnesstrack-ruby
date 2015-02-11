
require 'time'
require 'active_support/core_ext/string/inflections.rb'
#require 'openssl'
#require 'geokit'

module FitnessTrack
  module Gpx
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
        @lap = lap
      
        @time = Time.parse(@node.at_xpath('time').content).to_s
        @latitude = @node['lat'].to_f
        @longitude = @node['lon'].to_f
        @altitude_meters = @node.at_xpath('ele').content
        @distance_meters 
      end

      def distance_meters
        @distance_meters ||= set_distance_meters
      end

      def distance_miles
        @distance_meters.to_f / 1609.35
      end

      # set the distance in meters for this track point as calculated below
      def set_distance_meters
        this_index = lap.track_points.index(self)
        this_index ||= 0
        previous_ll =  this_index > 0 ? lap.track_points[this_index-1] : self  
        previous_distance  = previous_ll == self ? 0 : previous_ll.distance_meters

        from_last_track = distance([previous_ll.latitude, previous_ll.longitude],[latitude, longitude])
        distance_in_meters = previous_distance + from_last_track
  
        return distance_in_meters
      end

      #distance between 2 track points
      def distance (a, b)
        rad_per_deg = Math::PI/180  # PI / 180
        rkm = 6371                  # Earth radius in kilometers
        rm = rkm * 1000             # Radius in meters

        dlon_rad = (b[1]-a[1]) * rad_per_deg  # Delta, converted to rad
        dlat_rad = (b[0]-a[0]) * rad_per_deg

        lat1_rad, lon1_rad = a.map! {|i| i * rad_per_deg }
        lat2_rad, lon2_rad = b.map! {|i| i * rad_per_deg }

        a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
        c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

        rm * c # Delta in meters
      end

    end

  end

end