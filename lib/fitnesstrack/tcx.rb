require 'fitnesstrack/tcx/tcx_file'

module FitnessTrack
  # Module for the manipulation of Training Center XML files
  module Tcx
    # Reads the file at the given path and returns a new Tcx object
    def self.read(path)
      TcxFile.new(path)
    end
  end
end
