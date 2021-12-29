# frozen_string_literal: true

require 'calcifer/version'
require 'calcifer/finders/modules_finder'
require 'calcifer/finders/files_diff_finder'
require 'calcifer/finders/spec_files_related_finder'

module Calcifer
  class Error < StandardError; end

  def self.execute
    file_list = Calcifer::Finders::FilesDiffFinder.new.execute
    module_list = Calcifer::Finders::ModulesFinder.new(file_list).execute
    spec_files_path_list = Calcifer::Finders::SpecFilesRelatedFinder.new(module_list).execute

    printf %x[echo #{spec_files_path_list}]
  end
end
