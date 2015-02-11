

require 'fitnesstrack/gpx/track_point'

module FitnessTrack
  module Gpx
    # Represents a lap of an activity
    class Lap

      def self.create(node, activity)
       
          self.new(node, activity)
      end
    
      attr_reader :start_time, :total_time_seconds, :maximum_speed,
        :calories, :intensity, :trigger_method, :distance_miles, :info, :activity, :node
      attr_accessor :parent, :children, :distance_meters

      # Takes a Nokogiri XML node and an Activity object
      def initialize(node, activity)
       
        @node = node
        @activity = activity
        @start_time = Time.parse(activity.id).to_s

        @total_time_seconds = nil
        @distance_meters = nil
        @maximum_speed = nil 
        @calories = nil
        @intensity = nil
        @trigger_method = nil
        @distance_miles = 0

      end

      def distance_meters
        @distance_meters ||= track_points.last.distance_meters
      end

=begin
      def get_total_distance
        # distance meters calculated on each track point in turn
        # so that total distance is incremented correctly
        track_points.each do |trk|
          trk.set_distance_meters
        end

        total_distance = track_points.last.distance_meters
        return total_distance

      end
=end

      def distance_miles
        @distance_meters.to_f / 1609.35
      end

      # Item entry time, as a DateTime object, to the nearest second
      def time
        DateTime.strptime(@node['Time'], '%Y%m%d%H%M%S')
      end
      def time=(value)
        @node['Time'] = value.strftime('%Y%m%d%H%M%S')
      end

      # Returns an array containing each tracking point in the lap
      # The track points may be filtered by passing in a hash corresponding to the
      # required attributes, e.g. {:sport => 'Running'}
      def track_points(options = {})
        if @track_points.nil?
          track_nodes = @node.xpath('./trkpt')
          @track_points = track_nodes.map {|node| TrackPoint.create(node, self)}
        end

        ret = @track_points
        options.each_pair do |key, value|
          ret = ret.select {|section|
            activity.send(key) == value
          }
        end
        ret
      end
    end
  end
end

