# frozen_string_literal: true

require './lib/node'

# A Class representing a Binary Search Tree
class Tree
  def initialize(array)
    data = array.uniq.sort
    @root = build_tree(data)
  end

  def build_tree(data)
    return nil if data.empty?

    middle = data.size / 2

    root = Node.new(data[middle])
    root.left = build_tree(data[0...middle])
    root.right = build_tree(data[middle + 1..])
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

  def find(value, node = @root)
    return node if node.nil? || node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  def level_order(node = @root, queue = [], &block)
    yield node.data
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    return if queue.empty?

    level_order(queue.shift, queue, &block)
  end

  def preorder(node = @root, &block)
    return if node.nil?

    yield node.data
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  def inorder(node = @root, &block)
    return if node.nil?

    inorder(node.left, &block)
    yield node.data
    inorder(node.right, &block)
  end

  def postorder(node = @root, &block)
    return if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)
    yield node.data
  end

  def height(node = @root)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node, start = @root)
    return -1 if start.nil? # Base Case: Returns -1 If the root node is nil

    return 0 if node == start # If the node is the root node return 0

    distance = depth(node, start.left) # Checks the left subtree if it contains the node
    return distance + 1 if distance >= 0 # If it does then return distance + 1

    distance = depth(node, start.right) # Else checks the right subtree if it contains the node
    return distance + 1 if distance >= 0 # If it does then return distance + 1

    distance # Returns the depth
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return true if (
      (left_height - right_height).abs <= 1 &&
      balanced?(node.left) &&
      balanced?(node.right)
    )

    false
  end

  def rebalance
    data = []
    inorder { |element| data << element }
    @root = build_tree(data)
  end

  private

  def left_most(node = @root)
    node = node.left until node.left.nil?
    node
  end
end
