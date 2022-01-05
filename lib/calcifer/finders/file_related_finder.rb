# frozen_string_literal: true

module Calcifer
  module Finders
    class FileRelatedFinder
      attr_reader :related_spec_files

      def initialize(module_name)
        @module_name = module_name
      end

      def execute
        related_files_path.split
      end

      private

      def related_files_path
        `grep -Rlw '#{@module_names}' ./app`
      end
    end
  end
end
