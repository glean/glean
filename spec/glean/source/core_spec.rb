require 'spec_helper'

describe "Glean::Source::Core" do

  describe "#search", :vcr do
    let(:naics_codes) { "naics-codes" }
    let(:us_states) { "us-states" }

    subject(:results) { Glean::Source::Core.search("America").map {|r| r.name} }

    it "should find naics-codes source" do
      expect(results).to include(naics_codes)
    end

    it "and us-states source" do
      expect(results).to include(us_states)
    end

    context "case insensitive search" do
      subject(:result) { Glean::Source::Core.search("NaIcS").first.name }

      it "should find naics-codes source" do
        expect(result).to eq(naics_codes)
      end
    end
  end
end
