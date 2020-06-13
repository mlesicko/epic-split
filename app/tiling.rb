class Tile 
  attr_accessor :x, :y, :img
  def initialize(x, y, img)
    @x = x
    @y = y
    @img = img
  end

  def sprite
    [x, y, 128, 128, img]
  end
end


def draw_map args
  bg = arg.state.tiles.map { |x| 
    return x.map { |y| 
      return y.render
    }
  }

  if args.state.tile.scroll.y >= args.state.tile.h
      args.state.tile.scroll.y = 0
  else 
    args.state.tile.scroll.y += 1
  end

  args.outputs.sprites << [* bg]
  args.outputs.labels << [0, 0, "!", 4]
end
