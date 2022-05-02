# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/calcifer/**/*.rb"].sort.each { |file| require file }
require 'rgl/adjacency'

module Calcifer
  class Error < StandardError; end
  # isso é um teste 
  def self.execute
    spec_files_path = graph_list_file.map(&:related_files_paths).flatten
    spec_files_path_list = Calcifer::Finders::SpecFilesRelatedFinder.new(spec_files_path).execute

    printf `echo #{spec_files_path_list}`
  end

  private

  def graph_list_file
    graph_list_file = file_list.map(&->(file) { Calcifer::Buiders::RootFileBuilder.new(file).build }).compact

    graph_list_file.each do |graph|
      related_files = Calcifer::Finders::FileRelatedFinder.new(graph.module_name).execute
      graph_vertices = related_files.map { |related_file| [graph.file_path, related_file] }
      graph.graph_root.add_edges(*graph_vertices)
    end
  end

  def file_list
    Calcifer::Finders::FilesDiffFinder.new.execute
  end
end
