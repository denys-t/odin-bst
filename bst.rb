class Node
  attr_accessor :left, :right, :data

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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)

    node = @root
    new_node = Node.new(value)
    
    loop do
      if value == node.data
        return
      elsif value < node.data
        if node.left.nil?
          node.left = new_node
          return
        else
          node = node.left
        end
      elsif value > node.data
        if node.right.nil?
          node.right = new_node
          return
        else
          node = node.right
        end
      end
    end
  end

  def delete(value)
    node = @root
    parent = nil
    side = nil

    loop do
      if value == node.data
        # removing a leaf or a node with only one child
        if node.left.nil?
          if side == 'left'
            parent.left = node.right
          else
            parent.right = node.right
          end
        elsif node.right.nil?
          if side == 'left'
            parent.left = node.left
          else
            parent.right = node.left
          end
        else # removing a node with two children
          replacing_node = node.right
          until replacing_node.left.nil?
            replacing_parent = replacing_node
            replacing_node = replacing_node.left
          end
          
          replacing_parent.left = replacing_node.right
          replacing_node.left = node.left
          replacing_node.right = node.right

          if side == 'left'
            parent.left = replacing_node
          else
            parent.right = replacing_node
          end
        end

        return
      elsif value < node.data
        if node.left.nil?
          return
        else
          parent = node
          node = node.left
          side = 'left'
        end
      elsif value > node.data
        if node.right.nil?
          return
        else
          parent = node
          node = node.right
          side = 'right'
        end
      end
    end
  end

  def find(value, node = @root)
    if value == node.data 
      return node
    elsif value > node.data
      return node.right.nil? ? 'Not found' : find(value, node.right)
    else
      return node.left.nil? ? 'Not found' : find(value, node.left)
    end
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

t = Tree.new([0,1,3,5,7,9,11,13,15,17,19,21,23,25,27,29])