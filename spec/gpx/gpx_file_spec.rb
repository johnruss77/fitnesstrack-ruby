require 'spec_helper'
require 'nokogiri'
require 'fitnesstrack/gpx/gpx_file'

describe FitnessTrack::Gpx::GpxFile do

  describe "creation" do

    context "valid xml" do

      gpx = FitnessTrack::Gpx.read('examples/filetest/gpx_in.xml')

      it "should be valid" do
        expect(gpx).to be_valid
      end

	  it "should have activities" do
        expect(gpx.empty?).to eq false
      end

      it "should have filename" do
        expect(gpx.filename).to eq 'examples/filetest/gpx_in.xml'
      end

      it "should have root node" do
        expect(gpx.node).to_not eq nil
      end

      it "could clear activities" do
      	expect(gpx.clear_cache!).to eql nil
  	  end

    end

    context "invalid xml" do
      gpx = FitnessTrack::Gpx.read('examples/filetest/invalid.xml')
      	
      	it "should not be valid" do
          expect(gpx).to_not be_valid
          expect(gpx.errors).to include(:xml => 'invalid xml passed in')
        end

  	end

  end

end