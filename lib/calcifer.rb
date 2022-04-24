# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/calcifer/**/*.rb"].sort.each { |file| require file }
require 'rgl/adjacency'

module Calcifer
  class Error < StandardError; end
  class << self
    def execute
      file_list_finder = Calcifer::Factories::ListFileFactory.new(ARGV).fabricate
      file_list = file_list_finder.execute
      graph_list_file = Calcifer::Graph::GraphListFile.new(file_list).execute
      spec_files_path = graph_list_file.map(&:related_files_paths).flatten
      spec_files_path_list = Calcifer::Finders::SpecFilesRelatedFinder.new(spec_files_path).execute

      printf `echo #{spec_files_path_list}`
    end
  end
end
