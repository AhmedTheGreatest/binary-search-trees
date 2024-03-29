# frozen_string_literal: true

# A Class representing a Node in a Binary Search Tree
class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  include Comparable

  def <=>(other)
    @data <=> other.data
  end
end
