require "spec_helper"

describe Glean::Validator do
  describe ".run" do
    let(:validator_exists) { true }

    before { allow(described_class).to receive(:exists?).and_return(validator_exists) }

    context "dataset path provided" do
      let(:dataset_path) { "./dataset" }

      it "validates dataset at provided path" do
        expect(described_class).to receive(:validate).with(dataset_path)
        described_class.run(:dataset_path => dataset_path)
      end
    end

    context "dataset path is not provided" do
      let(:default_dataset_path) { "." }

      it "validates dataset at default path" do
        expect(described_class).to receive(:validate).with(default_dataset_path)
        described_class.run
      end
    end

    context "validator exists" do
      it "the validator is not installed" do
        installer = double
        expect(installer).to_not receive(:install_to)
        described_class.run(:installer => installer)
      end
    end

    context "validator is missing" do
      let(:validator_exists) { false }

      context "install path provided" do
        let(:install_path) { "/bin" }

        it "the validator is installed" do
          installer = double
          expect(installer).to receive(:install_to).with(:install_path => install_path)
          described_class.run(:installer => installer, :install_path => install_path)
        end
      end

      context "install path is not provided" do
        it "validator install path deferred to installer" do
          installer = double
          expect(installer).to receive(:install_to).with(:install_path => nil)
          described_class.run(:installer => installer)
        end
      end
    end
  end
end
