# frozen_string_literal: true

# A class that defines a node including the comparable module
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left, @right = nil
  end

  def <=>(other)
    data <=> other.data
  end
end
