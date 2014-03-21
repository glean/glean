require "spec_helper"

describe Glean::Validator::Package do
  describe ".url" do
    let(:name) { "darwin" }
    let(:arch) { "amd64" }
    let(:platform) { double(:name => name, :arch => arch, :unknown? => unknown) }

    context "platform is known" do
      let(:unknown) { false }
      let(:url) { "https://github.com/glean/glean-validator/raw/master/tomlv_#{name}_#{arch}.gz" }

      it "returns github url" do
        expect(described_class.url(platform)).to eq(url)
      end
    end

    context "platform is unknown" do
      let(:unknown) { true }

      it "throws an error" do
        expect(Glean::Validator::Error).to receive(:platform_unknown)
        described_class.url(platform)
      end
    end
  end
end
