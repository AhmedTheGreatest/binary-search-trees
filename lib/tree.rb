# frozen_string_literal: true

require './lib/node'

# A Class representing a Binary Search Tree
class Tree
  def initialize(data)
    @root = build_tree(data)
  end

  def build_tree(data)
    if data.empty?
      return false
    end

    sorted_data = data.uniq.sort
    middle = sorted_data.size / 2

    root = Node.new(sorted_data[middle])
    root.left = build_tree(sorted_data[0...middle])
    root.right = build_tree(sorted_data[middle+1..])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
