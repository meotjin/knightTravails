require_relative 'knight'
require_relative 'knight_moves_tree'

class Board
  def self.knight_move(start, target)
    knight = Knight.new(start)
    target_knight = nil

    depth_max = false
    depth_tracker = [1]
    depths_traversed = []
    queue = [knight]

    key = 0

    found = false
    until found
      if depth_tracker[0] == key
        depth_max = true
        key = 0
        depths_traversed.push(depth_tracker.shift)
      end

      key += 1 if depth_max == false

      current = queue.shift

      if current.position[0] == target[0] && current.position[1] == target[1]
        found = true
        target_knight = current
        break
      else
        current.build_children
        if depth_tracker[1].nil?
          depth_tracker[1] = current.childs.size
        else
          depth_tracker[1] += current.childs.size
        end

        current.childs.each do |child|
          queue.push child
        end
      end
      depth_max = false
    end
    print_path(start, target, depths_traversed.size + +2)
  end

  def self.print_path(start, target, depth)
    tree = KnightMovesTree.new(Knight.new(start), depth)
    tree.make_tree
    path = []
    puts "You made it in #{depth - 1} moves!"
    puts 'the path:'
    tree.find(target, path)
    path.each { |move| p move.position }
  end
end

Board.knight_move([0, 0], [7, 7])
