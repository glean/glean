require 'spec_helper'

describe "Glean::Source::Contrib" do

  describe "#search" do
    let(:name) { "lagalaxy/trophies" }
    let(:description) { "lagalaxy trophies: Major trophies won by the LA Galaxy" }

    subject(:result) { Glean::Source::Contrib.search("galaxy").first }

    it "should find lagalaxy trophies source" do
      expect(result.name).to eq(name)
    end

    it "and provide a description" do
      expect(result.description).to eq(description)
    end

    context "case insensitive search" do
      subject(:result) { Glean::Source::Contrib.search("GaLaXY").first }

      it "should still find lagalaxy trophies source" do
        expect(result.name).to eq(name)
      end

      it "and still provide a description" do
        expect(result.description).to eq(description)
      end
    end
  end
end
