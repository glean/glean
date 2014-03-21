require "sysinfo"

module Glean
  module Validator
    class Platform
      attr_reader :sys_info

      def initialize(sys_info=SysInfo.new)
        @sys_info = sys_info
      end

      def unknown?
        arch.nil? || name.nil?
      end

      def arch
        case sys_info.arch
        when :x86_64
          "amd64"
        when :x86
          "386"
        end
      end

      def name
        case [sys_info.os, sys_info.impl]
        when [:unix, :osx]
          "darwin"
        when [:unix, :linux], [:unix, :freebsd], [:unix, :netbsd]
          sys_info.impl.to_s
        end
      end
    end
  end
end
