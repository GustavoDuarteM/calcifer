# frozen_string_literal: true

module Calcifer
  module Finders
    class SpecFilesRelatedFinder
      attr_reader :related_spec_files

      def initialize(modules)
        @modules = modules
      end

      def execute
        @related_spec_files = specs_to_related_files.join(' ').strip
      end

      private

      def related_files_path
        module_names = @modules.join('\\|')
        `grep -Rlw '#{module_names}' ./app`
      end

      def specs_to_related_files
        related_files_path.split.map(&lambda { |file_path|
          file_path.gsub('./app', './spec').gsub('.rb', '_spec.rb')
        }).select { |file_path_spec| File.file?(file_path_spec) }
      end
    end
  end
end
