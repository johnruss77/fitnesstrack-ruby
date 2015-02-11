require 'fitnesstrack/gpx/gpx_file'

module FitnessTrack
  # Module for the manipulation of GPS Exchange Format files
  module Gpx
    # Reads the file at the given path and returns a new Gpx object
    def self.read(path)
      GpxFile.new(path)
    end
  end
end
