module Calcifer
  module Finders
    class FilesDiffFinder
      attr_reader :file_list

      def execute
        @file_list = git_files.split.map(&->(file_path){
          file = File.open(file_path)
          file if file.size.positive? && File.extname(file.path) == '.rb'
        }).compact
      end

      private 
      def git_files
        `git ls-files --others --exclude-standard && git diff --name-only --diff-filter=MCRTXB`
      end
    end
  end
end