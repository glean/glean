require "glean/validator/error"
require "glean/validator/installer"
require "glean/validator/package"
require "glean/validator/platform"

module Glean
  module Validator
    REPO                 = "https://github.com/glean/glean-validator"
    SUCCESS_MESSAGE      = "Glean Source Valid."
    DEFAULT_DATASET_PATH = "."

    def self.run(options = {})
      install_path = options[:install_path]
      dataset_path = options[:dataset_path] || DEFAULT_DATASET_PATH
      installer = options[:installer] || Installer.new

      installer.install_to(:install_path => install_path) unless exists?
      validate(dataset_path)
    end

    def self.exists?
      system "hash #{Package::NAME} 2>/dev/null"
    end

    def self.validate(dataset_path)
      output = %x(find #{dataset_path} -name '*.toml' | xargs #{Package::NAME} 2>&1)
      output == "" ? SUCCESS_MESSAGE : output
    end
  end
end
