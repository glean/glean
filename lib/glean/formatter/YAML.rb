module Glean
  module Formatter
    module YAML
      def self.format(obj)
        obj.to_yaml
      end
    end
  end
end
