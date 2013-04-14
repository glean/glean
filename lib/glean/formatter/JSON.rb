module Glean
  module Formatter
    module JSON
      def self.format(obj)
        obj.to_json
      end
    end
  end
end
