require 'calcifer/version'

module Calcifer
  class Error < StandardError; end

  def self.execute
    printf `echo $HOME`
  end
end
