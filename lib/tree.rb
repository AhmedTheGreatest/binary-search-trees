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

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = @root)
    return node if node.nil?

    # Node is in the left subtree
    if value < node.data
      node.left = delete(value, node.left)
    # Node is in the right subtree
    elsif value > node.data
      node.right = delete(value, node.right)
    # Node has been found
    else
      # If node has zero or one children
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # If node has 2 children, replace the node with the successor node
      successor_node = left_most(node.right) # Finds the successor node of the node to be deleted
      node.data = successor_node.data # Copies the sucessor node's data to the node to be deleted
      node.right = delete(successor_node.data, node.right) # Calls the delete method with the right subtree of the node
    end
    node
  end

  private

  def left_most(node = @root)
    node = node.left until node.left.nil?
    node
  end
end
