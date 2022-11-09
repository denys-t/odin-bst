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
    return node if value == node.data

    return node.right.nil? ? 'Not found' : find(value, node.right) if value > node.data

    return node.left.nil? ? 'Not found' : find(value, node.left)
  end

  def level_order_iterative(&block)
    queue = [].append(@root)
    result = [] unless block_given?

    until queue.length.zero?
      curr_el = queue.shift

      queue.append(curr_el.left) unless curr_el.left.nil?
      queue.append(curr_el.right) unless curr_el.right.nil?

      if block_given?
        yield curr_el
      else
        result.append(curr_el.data)
      end
    end

    return result unless block_given?
  end

  def level_order_recursive(&block)
    queue = [@root]
    result = [] unless block_given?

    lor(queue, result, &block)
  end

  def inorder(&block)
    traverse_tree(@root, 'in-order', [], &block)
  end

  def preorder(&block)
    traverse_tree(@root, 'pre-order', [], &block)
  end

  def postorder(&block)
    traverse_tree(@root, 'post-order', [], &block)
  end

  def height(node = @root)
    height_left = (node.left.nil? ? -1 : height(node.left))
    height_right = (node.right.nil? ? -1 : height(node.right))

    if height_left > height_right
      return height_left + 1
    else
      return height_right + 1
    end
  end

  def depth(node = @root)
    curr_node = @root
    depth = 0

    until node == curr_node do
      if node.data < curr_node.data
        depth += 1
        curr_node = curr_node.left
      elsif node.data > curr_node.data
        depth += 1
        curr_node = curr_node.right
      end
    end

    return depth
  end

  def balanced?
    (height(@root.left) - height(@root.right)).between?(-1, 1)
  end

  def rebalance
    unless balanced?
      data = inorder()
      @root = build_tree(data)
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

  def traverse_tree(node, method, result = [], &block)
    if block_given?
      yield node if method == 'pre-order'
      traverse_tree(node.left, method, result, &block) unless node.left.nil?
      yield node if method == 'in-order'
      traverse_tree(node.right, method, result, &block) unless node.right.nil?
      yield node if method == 'post-order'
    else
      result.append(node.data) if method == 'pre-order'
      traverse_tree(node.left, method, result, &block) unless node.left.nil?
      result.append(node.data) if method == 'in-order'
      traverse_tree(node.right, method, result, &block) unless node.right.nil?
      result.append(node.data) if method == 'post-order'

      return result
    end
  end

  def lor(queue, result, &block)
    if queue.empty?
      return result unless block_given?

      return
    end

    curr_el = queue.shift

    queue.append(curr_el.left) unless curr_el.left.nil?
    queue.append(curr_el.right) unless curr_el.right.nil?

    if block_given?
      yield curr_el
    else
      result.append(curr_el.data)
    end

    lor(queue, result, &block)
  end
end