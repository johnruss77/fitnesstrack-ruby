require 'fitnesstrack/gpx/lap'

module FitnessTrack
  module Gpx
    # Represents a tracked activity
    class Activity
      # Creates a new gpx activity
      def self.create(node, gpx)
          self.new(node, gpx)
      end

      attr_reader :node

      # Takes a Nokogiri XML node and the parent Nvo object
      def initialize(node, gpx)
        @node = node
        @gpx = gpx
      end

      def sport
        # gpx file have no record of the sport details in activity
        'Unknown'
      end

      # no id so use the time to generate a unique id
      def id
        @node.at_xpath('./metadata/time').content   
      end

      # Clear cached data.
      # This forces the object to read the XML again next time data is
      # requested, rather than relying on cached data.
      def clear_cache!
        @node = nil
        @gpx = nil
      end

      # Returns all the laps for this activity.
      def laps(options = {})
        if @laps.nil?
          @laps = @node.xpath('trk/trkseg').map {|node| Lap.create(node, self)}
        end

        ret = @laps

        # Other options can be passed on to the lap itself
        options.each_pair do |key, value|
          ret = ret.select {|lap|
            lap.send(key) == value
          }
        end
        ret
      end

      # Returns true if the activity has no laps
      def empty?
        self.laps.empty?
      end

      # Remove this activity from the file.
      def remove!
        @node.remove
        @gpx.clear_cache!
        @removed = true
      end

      # Returns true if the XML node has been removed
      def removed?
        @removed
      end

    end
  end
end
