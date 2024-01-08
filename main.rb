# frozen_string_literal: true

require './lib/tree'

tree = Tree.new((Array.new(15) { rand(1..100) }))

puts tree.balanced?

print "Level Order: "
print (tree.level_order { |node| print "#{node}, " })
puts ""

print "Pre Order: "
print (tree.preorder { |node| print "#{node}, " })
puts ""

print "In Order: "
print (tree.inorder { |node| print "#{node}, " })
puts ""

print "Post Order: "
print (tree.postorder { |node| print "#{node}, " })
puts ""

10.times do
  tree.insert(rand(100...200))
end

puts tree.balanced?

tree.rebalance

puts tree.balanced?

print "Level Order: "
print (tree.level_order { |node| print "#{node}, " })
puts ""

print "Pre Order: "
print (tree.preorder { |node| print "#{node}, " })
puts ""

print "In Order: "
print (tree.inorder { |node| print "#{node}, " })
puts ""

print "Post Order: "
print (tree.postorder { |node| print "#{node}, " })
puts ""
