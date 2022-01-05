# frozen_string_literal: true

module Calcifer
  module Buiders
    class RootFileBuilder
      def initialize(file)
        @file = file
      end

      def build
        return unless @file

        module_name = Calcifer::Finders::ModuleNameFinder.new(@file).execute
        Calcifer::Graph::RootFile.new(module_name, @file) if module_name
      end
    end
  end
end
