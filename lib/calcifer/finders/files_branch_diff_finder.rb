# frozen_string_literal: true

module Calcifer
  module Finders
    class FilesBranchDiffFinder
      def initialize(branch)
        @branch = branch
      end

      def execute
        @file_list = git_files.split.map(&lambda { |file_path|
          file = File.open(file_path)
          file if file.size.positive? && File.extname(file.path) == '.rb'
        }).compact
      end

      def git_files
        `git diff --name-only #{@branch}...`
      end
    end
  end
end
