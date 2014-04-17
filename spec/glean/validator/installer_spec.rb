require "spec_helper"

describe Glean::Validator::Installer do

  subject(:installer) { described_class.new }

  describe "#install_to" do
    context "install path provided" do
      let(:options) { { :install_path => "/bin" } }

      it "installs validator without asking questions" do
        expect(installer).to_not receive(:proceed?)
        expect(installer).to_not receive(:install_where?)
        expect(installer).to receive(:download)
        installer.install_to(options)
      end
    end

    context "install path is not provided" do
      let(:options) { { } }

      context "user asks installer to stop" do
        it "aborts and notifies user the validator is required" do
          allow(installer).to receive(:proceed?).and_return(false)
          expect(installer).to_not receive(:download)
          expect{ installer.install_to(options) }.to raise_error(GLI::CustomExit)
        end
      end

      context "user asks installer to proceed" do
        it "asks user where to install the validator and installs it" do
          installer.stub(:proceed?).and_return(true)
          expect(installer).to receive(:install_where)
          expect(installer).to receive(:download)
          installer.install_to(options)
        end
      end
    end

    context "validator download fails" do
      it "alerts the user of the failure" do
        allow(installer).to receive(:proceed?).and_return(true)
        allow(installer).to receive(:install_where)
        allow(installer).to receive(:open).and_raise(StandardError)
        expect(Glean::Validator::Error).to receive(:validator_download).with(kind_of(String))
        installer.install_to
      end
    end
  end
end
