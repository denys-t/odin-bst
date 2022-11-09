# frozen_string_literal: true

require_relative 'node.rb'
require_relative 'bst.rb'

puts
puts('1. Create a binary search tree from an array of random numbers')
arr = Array.new(15) { rand(1..100) }
tree = Tree.new(arr)

puts
puts('2. Confirm that the tree is balanced by calling #balanced?')
if tree.balanced?
  puts('The tree is balanced.')
else
  puts('The tree is not balanced.')
end

puts
puts('3. Print out all elements in level, pre, post, and in order')
puts("Level-order traversal: #{tree.level_order_iterative}")
puts("In-order traversal: #{tree.inorder}")
puts("Pre-order traversal: #{tree.preorder}")
puts("Post-order traversal: #{tree.postorder}")

puts
puts('4. Unbalance the tree by adding several numbers > 100')
arr = Array.new(10) { rand(100..200) }
arr.each { |e| tree.insert(e) }
puts("#{arr} elements were inserted in the tree")

puts
puts('5. Confirm that the tree is unbalanced')
if tree.balanced?
  puts('The tree is still balanced.')
else
  puts('The tree is now unbalanced.')
end

puts
puts('6. Balance the tree')
tree.rebalance

puts
puts('7. Confirm that the tree is balanced')
if tree.balanced?
  puts('The tree is now balanced.')
else
  puts('The tree is still unbalanced.')
end

puts
puts('8. Print out all elements in level, pre, post, and in order')
puts("Level-order traversal: #{tree.level_order_iterative}")
puts("In-order traversal: #{tree.inorder}")
puts("Pre-order traversal: #{tree.preorder}")
puts("Post-order traversal: #{tree.postorder}")