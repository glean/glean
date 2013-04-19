module Glean
  module Formatter
    def self.format(format)
      submodules.detect do |submodule|
        format == submodule.name.split("::").last.downcase
      end
    end

    def self.available_formatters
      submodules.collect do |submodule|
        submodule.name.split("::").last.downcase
      end
    end

    def self.submodules
      constants.collect do |const_name|
        const_get(const_name)
      end.select do |const|
        const.class == Module
      end
    end
  end
end
