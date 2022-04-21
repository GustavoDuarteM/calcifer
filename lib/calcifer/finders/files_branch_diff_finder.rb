# frozen_string_literal: true

module Calcifer
  module Finders
    class FilesBranchDiffFinder

      def initialize
        # @TODO - adicionar configuração para sinalizar branch master
        @parent_branch = nil
      end

      def execute
        @file_list = git_files.split.map(&lambda { |file_path|
          file = File.open(file_path)
          file if file.size.positive? && File.extname(file.path) == '.rb'
        }).compact
      end

      def git_parent_branch
        return @parent_branch if @parent_branch.present?

        `git log --pretty=format:'%D' HEAD^ | grep 'origin/' | head -n1 | sed 's@origin/@@' | sed 's@,.*@@'`
      end

      # def self.git_parent_branch
      #   `
      #   git show-branch -a \
      #   | grep '\*' \
      #   | grep -v \`git rev-parse --abbrev-ref HEAD\` \
      #   | head -n1 \
      #   | sed 's/.*\[\(.*\)\].*/\1/' \
      #   | sed 's/[\^~].*//'
      #   `
      # end

			def git_current_branch
				`git branch --show-current`
			end

      def git_files
        `git diff --name-only #{git_parent_branch}...#{git_current_branch}`
      end
    end
  end
end
