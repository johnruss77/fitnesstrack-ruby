require 'spec_helper'
require 'nokogiri'

describe FitnessTrack::Tcx::TcxFile do
  describe "creation" do
    
    context "valid xml" do
      tcx = FitnessTrack::Tcx.read('examples/filetest/tcx_in.xml')

      it "should be valid" do
        expect(tcx).to be_valid
      end

      it "should have activities" do
        expect(tcx.empty?).to eq false
      end

      it "should have filename" do
        expect(tcx.filename).to eq 'examples/filetest/tcx_in.xml'
      end

      it "should have root node" do
        expect(tcx.node).to_not eq nil
      end

      it "could clear activities" do
        expect(tcx.clear_cache!).to eql nil
      end

    end

    context "invalid xml" do
      tcx = FitnessTrack::Tcx.read('examples/filetest/invalid.xml')

      it "should not be valid" do  
        expect(tcx).to_not be_valid
        expect(tcx.errors).to include(:xml => 'invalid xml passed in')
      end

      it "should not have activities" do
        expect(tcx.empty?).to eq true
      end



    end

  end
end