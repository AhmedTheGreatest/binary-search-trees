# frozen_string_literal: true

require './lib/tree'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.insert(0)
tree.delete(8)
tree.pretty_print
tree.postorder { |x| puts "Value: #{x}" }
puts tree.height
