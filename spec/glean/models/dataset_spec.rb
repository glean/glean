require 'spec_helper'

describe "Glean::Dataset" do
  subject(:dataset) { Glean::Dataset.new("glean/countries", "~") }

  describe "#identifier" do

    it "should return the identifier" do
      expect(dataset.identifier).to eq("glean/countries")
    end
  end
end
