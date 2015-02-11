require 'nokogiri'

module FitnessTrack
  # Generic FitnessTrack file, subclassed for each file type
  class FitnessTrackFile
    attr_reader :filename, :node

    # Pass a path to a fitness tracking file file
    def initialize(path)
      @filename = path
      file = nil
      file = open(path)  
      
      @document = Nokogiri::XML(file)
      @document.remove_namespaces!
      @node = @document.root
      unless self.valid?
        raise "Unable to load file.  Is it in the correct format?"
      end
    end

    # Indicates whether or not this file is valid.  This should be overloaded
    # by all subclasses.
    def valid?
      false
    end

  end
end