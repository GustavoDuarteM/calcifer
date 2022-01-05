# frozen_string_literal: true

module Calcifer
  module Finders
    class SpecFilesRelatedFinder
      attr_reader :related_spec_files

      def initialize(related_files_path)
        @related_files_path = related_files_path
      end

      def execute
        @related_spec_files = specs_to_related_files.join(' ').strip
      end

      def specs_to_related_files
        @related_files_path.map(&lambda { |file_path|
          spec_file_path = file_path.gsub('./app', './spec').gsub('.rb', '_spec.rb')
          File.file?(spec_file_path) ? spec_file_path : nil
        }).compact
      end
    end
  end
end
