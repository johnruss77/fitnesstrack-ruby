
require 'time'
require 'active_support/core_ext/string/inflections.rb'
require 'fitnesstrack/tcx/track_point'

module FitnessTrack
  module Tcx
    # Represents a lap of an activity
    class Lap

      def self.create(node, activity)
        #if node.at_xpath('@IsRoute').nil?
          self.new(node, activity)
        #else
        #  Route.new(node, nvo)
        #end
      end
    
      attr_reader :start_time, :total_time_seconds, :distance_meters, :maximum_speed,
        :calories, :intensity, :trigger_method, :distance_miles, :info, :activity, :node
      attr_accessor :parent, :children

      # Takes a Nokogiri XML node and a Section object
      def initialize(node, activity)
       
        @node = node
        @activity = activity
        @start_time = Time.parse(@node['StartTime']).to_s

        other_attributes = Hash[node.xpath('./*').select { |v| v.name !='Track' && v.name != 'Extensions'}.map { |inf| [inf.name.underscore, inf.content] }]
        other_attributes.each { |name, value| instance_variable_set("@#{name}", value) }

        #@xsp = @node['XSP']
        #@parent = nil
        #@children = []
      end

      def distance_miles
        @distance_meters.to_f / 1609.35
      end

      # Convert to String
      def to_s(options = {})
        case options[:format]
          when :long
            "#{@id} #{@xsp.ljust(3)} | #{@parent.id  rescue '  '}"
          else
            "#{@id} (#{@xsp})"
        end
      end
      alias_method :inspect, :to_s

      # Clear cached data.
      # This forces the object to read the XML again next time data is
      # requested, rather than relying on cached data.
      def clear_cache!
        # This can be overridden
      end

      # Returns an array containing each tracking point in the lap
      # The track points may be filtered by passing in a hash corresponding to the
      # required attributes, e.g. {:sport => 'Running'}
      def track_points(options = {})
        if @track_points.nil?
          track_nodes = @node.xpath('./Track/Trackpoint')
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
