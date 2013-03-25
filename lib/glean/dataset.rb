module Glean
  class Dataset
    attr_reader :identifier

    def initialize(identifier, dir="~")
      @identifier = identifier
      @dir = dir
      sync
    end

    def storage_path
      File.join(File.expand_path(@dir), ".glean")
    end

    def path
      File.join(storage_path, identifier)
    end

    def sync
      Dir.mkdir(storage_path) unless File.exists?(storage_path)
      begin
        g = Git.open(path)
        g.pull
      rescue
        Git.clone("http://github.com/#{identifier}", identifier, :path => storage_path)
      end
    end

    def each
      Dir.glob(File.join(path, "**/*.toml")) do |f|
        yield TOML.load_file(f)
      end
    end
  end
end
