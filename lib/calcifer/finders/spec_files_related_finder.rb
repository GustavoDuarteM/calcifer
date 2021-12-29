# frozen_string_literal: true

module Calcifer
  module Finders
    class SpecFilesRelatedFinder
      attr_reader :related_files_spec

      def initialize(modules)
        @modules = modules
      end

      def execute
        @related_files_spec = specs_to_related_files.join(' ').strip
      end

      private

      def related_files_path
        `grep -Rlw '#{@modules.join('\\|')}' ./app`
      end

      def specs_to_related_files
        related_files_path.split.map(&lambda { |file_path|
          file_path.gsub('./app', './spec').gsub('.rb', '_spec.rb')
        }).select { |file_path_spec| File.file?(file_path_spec) }
      end
    end
  end
end
