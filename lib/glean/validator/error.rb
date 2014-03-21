require "gli/exceptions"

module Glean
  module Validator
    module Error
      def self.package_required
        quit("Validator (#{Package::NAME}) is required.")
      end

      def self.platform_unknown
        quit("Validator can't determine your platform.\n" +
             "Please install the Validator (#{Package::NAME}).\n" +
             Validator::REPO)
      end

      def self.validator_download(message)
        quit("Validator download error: #{message}.\n" +
             "Please try again later or install the Validator (#{Package::NAME}).\n" +
             Validator::REPO)
      end

      def self.quit(error)
        raise GLI::CustomExit.new(error, 1)
      end
    end
  end
end
