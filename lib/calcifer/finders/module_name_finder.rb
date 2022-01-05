# frozen_string_literal: true

module Calcifer
  module Finders
    class ModuleNameFinder
      MODULE_REGEX = /^(module)\s\w+/.freeze
      CLASS_REGEX = /^(class)\s\w+/.freeze
      ONE_LINE_CLASS_REGEX = /^(class)\s\w+\s<\s\w+;\s(end)/.freeze
      attr_reader :modules

      def initialize(file)
        @file = file
      end

      def execute
        return unless @file

        module_name = ''
        @file.readlines.each do |line|
          next if line.strip.match(ONE_LINE_CLASS_REGEX)&.length&.positive?

          if line.strip.match(MODULE_REGEX)&.length&.positive?
            module_name += "#{line.gsub('module', '').strip}::"
          elsif line.strip.match(CLASS_REGEX)&.length&.positive?
            module_name += line.gsub('class', '').gsub(/<(.*)/, '').strip
            break
          end
        end

        module_name.length.positive? ? module_name : nil
      end
    end
  end
end
