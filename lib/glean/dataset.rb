module Glean
  class Dataset
    attr_reader :identifier

    def initialize(identifier)
      @identifier = identifier
      sync
    end

    def storage_path
      File.join(File.expand_path("~"), ".glean")
    end

    def path
      File.join(storage_path, identifier)
    end

    def sync
      begin
        g = Git.open(path)
        g.pull
      rescue
        Git.clone("http://github.com/#{identifier}", identifier, :path => storage_path)
      end
    end

    def each
      Dir.glob(File.join(path, "*")) do |d|
        yield directory_hash(d)
      end
    end

    def directory_hash(path)
      data = {}
      Dir.foreach(path) do |entry|
        next if (entry == '..' || entry == '.')
        full_path = File.join(path, entry)
        if File.directory?(full_path)
          data[entry.to_sym] = directory_hash(full_path)
        else
          data[entry.to_sym] = File.read(full_path).chomp
        end
      end
      return data
    end
  end
end
