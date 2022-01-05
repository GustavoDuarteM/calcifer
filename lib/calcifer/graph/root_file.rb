# frozen_string_literal: true

module Calcifer
  module Graph
    class RootFile
      attr :graph_root, :module_name, :file_path

      def initialize(module_name, file)
        @module_name = module_name
        @file = file
        @file_path = file.path
        build_graph_root
      end

      def add_related_file_path(file_path)
        @graph_root.add_edge(@file.path, file_path)
      end

      def related_files_paths
        @graph_root.vertices - [@file.path]
      end

      private

      def build_graph_root
        @graph_root = RGL::DirectedAdjacencyGraph.new
        @graph_root.add_vertex(@file.path)
      end
    end
  end
end
