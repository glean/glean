module Glean
  class Datum
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def to_s
      File.basename(path)
    end
  end
end
