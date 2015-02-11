require 'fitnesstrack/tcx/lap'

module FitnessTrack
  module Tcx
    # Represents a tracked activity
    class Activity
      def self.create(node, tcx)
          self.new(node, tcx)
      
      end

      attr_reader :node

      # Takes a Nokogiri XML node and the parent Nvo object
      def initialize(node, tcx)
        @node = node
        @tcx = tcx
      end

      def sport
        @node['Sport']
      end

      # Activity ID
      def id
        @node.xpath('./Id').first.content
        
      end

      def id=(value)
        @node['Id'] = value
      end

      # Clear cached data.
      # This forces the object to read the XML again next time data is
      # requested, rather than relying on cached data.
      def clear_cache!
        @laps = nil
      end

  
      # Returns all laps for this activity.
 
      def laps(options = {})
        if @laps.nil?
          @laps = @node.xpath('Lap').map {|node| Lap.create(node, self)}
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

      # Remove this section from the file.
      def remove!
        @node.remove
        @tcx.clear_cache!
        @removed = true
      end

      # Returns true if the XML node has been removed
      def removed?
        @removed
      end
 
    end
  end
end
