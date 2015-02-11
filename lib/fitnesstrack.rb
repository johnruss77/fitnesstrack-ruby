
# Add lib directory to search path, if necessary
FitnessTrackLibDir = File.dirname(__FILE__)
unless $:.include? FitnessTrackLibDir
  $: << FitnessTrackLibDir
end
require 'fitnesstrack/tcx'
require 'fitnesstrack/gpx'
require 'fitnesstrack/version'
require 'nokogiri'
require 'time'
require 'active_support/core_ext/string/inflections.rb'

module FitnessTrack
	class TestClass

	end
end

