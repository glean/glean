require "spec_helper"

describe Glean::Validator::Platform do
  subject(:platform) { described_class.new(sys_info) }

  describe "#unknown?" do
    context "architecture is unknown" do
      let(:sys_info) { double(:arch => nil, :os => :unix, :impl => :osx) }

      it "true" do
        expect(platform.unknown?).to be_true
      end
    end

    context "operating system and implementation are unknown" do
      let(:sys_info) { double(:arch => :x86_64, :os => nil, :impl => nil) }

      it "true" do
        expect(platform.unknown?).to be_true
      end
    end

    context "architecture, operating system and implementation are known" do
      let(:sys_info) { double(:arch => :x86_64, :os => :unix, :impl => :osx) }

      it "false" do
        expect(platform.unknown?).to be_false
      end
    end
  end

  describe "#arch" do
    context "64bit architecture" do
      let(:sys_info) { double(:arch => :x86_64) }

      it "amd64" do
        expect(platform.arch).to eq("amd64")
      end
    end

    context "32bit architecture" do
      let(:sys_info) { double(:arch => :x86) }

      it "386" do
        expect(platform.arch).to eq("386")
      end
    end

    context "unknown" do
      let(:sys_info) { double(:arch => :foo) }

      it "nil" do
        expect(platform.arch).to be_nil
      end
    end
  end

  describe "#name" do
    context "OS X operating system" do
      let(:sys_info) { double(:os => :unix, :impl => :osx) }

      it "darwin" do
        expect(platform.name).to eq("darwin")
      end
    end

    context "Linux operating system" do
      let(:sys_info) { double(:os => :unix, :impl => :linux) }

      it "linux" do
        expect(platform.name).to eq("linux")
      end
    end

    context "FreeBSD operating system" do
      let(:sys_info) { double(:os => :unix, :impl => :freebsd) }

      it "freebsd" do
        expect(platform.name).to eq("freebsd")
      end
    end

    context "NetBSD operating system" do
      let(:sys_info) { double(:os => :unix, :impl => :netbsd) }

      it "netbsd" do
        expect(platform.name).to eq("netbsd")
      end
    end
  end
end
