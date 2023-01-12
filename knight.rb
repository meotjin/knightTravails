class Knight
  attr_reader :position, :childs

  POSIBLE_ROUTS = [[1, 2], [2, 1], [-1, 2], [2, -1], [1, -2], [-2, 1], [-1, -2], [-2, -1]].freeze

  def initialize(position)
    @position = position
    @childs = []
  end

  def build_children
    @childs = POSIBLE_ROUTS.map do |rout|
                [rout[0] + position[0], rout[1] + position[1]]
              end.select { |pos| pos[0].between?(0, 7) && pos[1].between?(0, 7) }
    @childs.map! { |child| Knight.new(child) }
  end
end
