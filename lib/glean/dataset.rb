module Glean
  class Dataset
    attr_reader :identifier

    def initialize(identifier)
      @identifier = identifier
    end

    def storage_path
      File.join(File.expand_path("~"), ".glean")
    end

    def path
      File.join(storage_path, identifier)
    end

    def download!
      Git.clone("http://github.com/#{identifier}", identifier, :path => storage_path)
    end

    def each_datum
      Dir.glob(File.join(path, "*")) do |d|
        yield Datum.new(d)
      end
    end
  end
end
