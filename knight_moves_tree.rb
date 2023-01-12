require_relative 'knight'

class KnightMovesTree
  def initialize(knight, depth)
    @root = knight
    @depth = depth
  end

  def make_tree(node = @root, key = 1)
    return if key == @depth

    node.build_children
    node.childs.each { |child| make_tree(child, key + 1) }
  end

  def find(position, array = [], node = @root)
    array.push node
    return true if node.position[0] == position[0] && node.position[1] == position[1]

    unless node.childs.empty?
      node.childs.each do |child|
        return true if find(position, array, child)
      end
    end
    array.pop
    false
  end

  def print_tree
    queue = [@root]
    until queue.empty?
      node = queue.shift
      print "#{node.position} - "
      node.childs.each { |child| queue.push child } unless node.childs.empty?
    end
  end
end
