require 'fitnesstrack/fitnesstrack_file'
require 'fitnesstrack/tcx/activity'

module FitnessTrack
  module Tcx
    # Top-level object representing the NVO file itself
    class TcxFile < FitnessTrackFile
      # Returns true if the file appears to be a valid NVO file
      def valid?
        !@node.xpath('./Activities').empty?
      end

      # Returns true if there are no activities in the file
      def empty?
        activities.empty?
      end

      # Clear cached data.
      # This forces the object to read the XML again next time data is
      # requested, rather than relying on cached data.
      def clear_cache!
        @activities = nil
      end

      # Returns an array containing each section in the file
      # The sections may be filtered by passing in a hash corresponding to the
      # required attributes, e.g. {:sport => 'Running'}
      def activities(options = {})
        if @activities.nil?
          activity_nodes = @node.xpath('./Activities/Activity')
          #puts activity_nodes
          @activities = activity_nodes.map {|node| Activity.create(node, self)}
        end

        ret = @activities
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
