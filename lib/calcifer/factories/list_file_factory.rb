# frozen_string_literal: true

module Calcifer
  module Factories
    class ListFileFactory
      PARAM_BRANCH = ['-b', '-branch'].freeze

      def initialize(params)
        @params = params
      end

      def fabricate
        extract_parameters

        return Calcifer::Finders::FilesDiffFinder.new if @branch.nil?

        Calcifer::Finders::FilesBranchDiffFinder.new(@branch)
      end

      private

      def extract_parameters
        params_list.each do |param|
          param_branch(param)
        end
      end

      def params_list
        @params_list = []
        (0..@params.length - 1).step(2) do |num|
          range = 2 + num
          @params_list << @params[num..range]
        end

        @params_list
      end

      def param_branch(array_param)
        param, value = array_param

        return unless PARAM_BRANCH.include?(param)

        @branch = value
      end
    end
  end
end
