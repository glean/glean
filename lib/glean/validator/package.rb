module Glean
  module Validator
    module Package
      NAME = "tomlv"

      def self.url(platform=Platform.new)
        Error.platform_unknown if platform.unknown?

        filename = "#{NAME}_#{platform.name}_#{platform.arch}.gz"
        "https://github.com/glean/glean-validator/raw/master/#{filename}"
      end
    end
  end
end
