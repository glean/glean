require "open-uri"
require "zlib"
require "highline/import"

module Glean
  module Validator
    class Installer
      DEFAULT_INSTALL_PATH  = "/usr/local/bin"

      attr_reader :install_path, :package_name, :package_url

      def initialize(options = {})
        @package_name = options[:package_name] || Package::NAME
        @package_url = options[:package_url] || Package.url
      end

      def install_to(options = {})
        @install_path = options[:install_path]

        unless force?
          proceed? ? install_where : Error.package_required
        end

        download
      end

      def force?
        !install_path.nil? && !install_path.empty?
      end

      def proceed?
        question = "The Validator (#{package_name}) is not available, would you like to install? "
        ask(question) { |q| q.default = "Y/n" } == "Y" ? true : false
      end

      def install_where
        question = "Where would you like to install the Validator (#{package_name})? "
        @install_path = ask(question) { |q| q.default = DEFAULT_INSTALL_PATH }
      end

      def download
        open(package_url, "rb") do |remote_package|
          Zlib::GzipReader.open(remote_package) do |uncompressed_package|
            File.open(package_destination, "wb") do |local_package|
              IO.copy_stream(uncompressed_package, local_package)
            end
          end
        end

        File.chmod(0755, package_destination)
      rescue StandardError => e
        Error.validator_download(e.message)
      end

      def package_destination
        File.join(install_path, package_name)
      end
    end
  end
end
