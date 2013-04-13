module Glean
  module Source
    def self.resolve_identifier(identifier)
      if identifier.include?("/")
        identifier
      else
        "glean/#{identifier}"
      end
    end
  end
end
