class Node
  attr_accessor :left, :right

  def initialize(data)
    @data = data
    @left = @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  private

  def build_tree(array)
    array = array.uniq.sort

    return bst(array)
  end

  def bst(array)
    return nil if array.length.zero?

    mid_i = (array.length / 2).to_f.floor

    node = Node.new(array[mid_i])
    return node if array.length == 1

    node.left = bst(array[0..mid_i - 1])
    node.right = bst(array[mid_i + 1..array.length - 1])

    return node
  end
end

Tree.new([0,1,2,3])