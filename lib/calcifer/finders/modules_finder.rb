# frozen_string_literal: true

module Calcifer
  module Finders
    class MudulesFinder
      MODULE_REGEX = /^(module)\s\w+/.freeze
      CLASS_REGEX = /^(class)\s\w+/.freeze
      attr_reader :modules

      def initialize(file_list)
        @file_list = file_list
        @modules = []
      end

      def execute
        @file_list.each do |file|
          module_name = build_module_name(file)
          @modules << module_name if module_name.length.positive?
        end
        @modules
      end

      private

      def build_module_name(file)
        module_name = ''
        file.readlines.each do |line|
          if line.strip.match(MODULE_REGEX)&.length&.positive?
            module_name += "#{line.gsub('module', '').strip}::"
          elsif line.strip.match(CLASS_REGEX)&.length&.positive?
            return module_name += line.gsub('class', '').gsub(/<(.*)/, '').strip
          end
        end
      end
    end
  end
end
