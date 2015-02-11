
# Add lib directory to search path, if necessary
FitnessTrackLibDir = File.dirname(__FILE__)
unless $:.include? FitnessTrackLibDir
  $: << FitnessTrackLibDir
end
require 'fitnesstrack/tcx'
require 'fitnesstrack/gpx'
require "fitnesstrack/version"

