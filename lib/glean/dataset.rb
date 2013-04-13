module Glean
  class Dataset
    attr_reader :identifier

    def self.resolve_identifier(identifier)
      if identifier.include?("/")
        identifier
      else
        "glean/#{identifier}"
      end
    end

    def initialize(identifier, dir="~")
      @identifier = Dataset.resolve_identifier(identifier)
      @dir = dir
      sync
    end

    def storage_path
      File.join(File.expand_path(@dir), ".glean")
    end

    def path
      File.join(storage_path, identifier)
    end

    def repo_url
      "http://github.com/#{identifier}"
    end

    def sync
      Dir.mkdir(storage_path) unless File.exists?(storage_path)
      begin
        g = Git.open(path)
        g.pull
      rescue
        Git.clone(repo_url, identifier, :path => storage_path)
      end
    end

    def each
      Dir.glob(File.join(path, "**/*.toml")) do |f|
        yield TOML.load_file(f)
      end
    end
  end
end
