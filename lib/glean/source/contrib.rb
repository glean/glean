module Glean
  module Source
    module Contrib

      class SearchResult < Struct.new(:name, :description)
      end

      def self.search(query)
        query = "" if query.nil?
        Glean::Dataset.new('glean/glean-contrib').each_with_object([]) do |source, results|
          name = source.identifier
          description = "#{source.name}: #{source.description}"
          results << SearchResult.new(name, description) if description.include?(query)
        end
      end
    end
  end
end
