# frozen_string_literal: true

module Calcifer
  module Graph
    class GraphListFile
      def initialize(file_list)
        @file_list = file_list
      end

      def execute
        graph_list_file = @file_list.map(&->(file) { Calcifer::Buiders::RootFileBuilder.new(file).build }).compact

        graph_list_file.each do |graph|
          related_files = Calcifer::Finders::FileRelatedFinder.new(graph.module_name).execute
          graph_vertices = related_files.map { |related_file| [graph.file_path, related_file] }
          graph.graph_root.add_edges(*graph_vertices)
        end

        graph_list_file
      end

      def file_list
        Calcifer::Finders::FilesDiffFinder.new.execute
      end
    end
  end
end
