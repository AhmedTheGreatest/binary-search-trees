# frozen_string_literal: true

require './lib/node'

# A Class representing a Binary Search Tree
class Tree
  def initialize(data)
    @root = build_tree(data)
  end

  def build_tree(data)
    return nil if data.empty?

    sorted_data = data.uniq.sort
    middle = sorted_data.size / 2

    root = Node.new(sorted_data[middle])
    root.left = build_tree(sorted_data[0...middle])
    root.right = build_tree(sorted_data[middle + 1..])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    return nil if value == node.data

    p node.left
    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end
end
