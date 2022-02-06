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
        @module_name = []
      end

      def execute
        return unless @file

        @file.readlines.each do |line|
          next if one_line_class_definition?(line)

          if module_definition?(line)
            @module_name << line.gsub('module', '').strip
          elsif class_definition?(line)
            @module_name << line.gsub('class', '').gsub(/<(.*)/, '').strip
            break
          end
        end

        mount_module_name
      end

      private

      def one_line_class_definition?(line)
        line.strip.match(ONE_LINE_CLASS_REGEX)&.length&.positive?
      end

      def module_definition?(line)
        line.strip.match(MODULE_REGEX)&.length&.positive?
      end

      def class_definition?(line)
        line.strip.match(CLASS_REGEX)&.length&.positive?
      end

      def mount_module_name
        return unless @module_name.length.positive?

        @module_name.join('::')
      end
    end
  end
end
