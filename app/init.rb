def init_trucks args
  args.state.trucks.left.w ||= 88
  args.state.trucks.left.h ||= 218
  args.state.trucks.right.w ||= 88
  args.state.trucks.right.h ||= 218
  
  args.state.trucks.left.x ||= 520
  args.state.trucks.left.y ||= 310
  args.state.trucks.right.x ||= 650
  args.state.trucks.right.y ||= 310
end

def init_tiles args
  args.state.screen.w ||= 1280
  args.state.screen.h ||= 720
  args.state.tile.w ||= 128
  args.state.tile.h ||= 128
  args.state.tile.scroll.y ||= 0
  
  tile_count_x = (args.state.screen.w / args.state.tile.w).to_i
  tile_count_y = (args.state.screen.h / args.state.tile.h).to_i 
  tiles_x = (0..tile_count_x).to_a
  tiles_y = (0..tile_count_y + 1).to_a
  args.state.tiles ||= tiles_x.map { |x| 
    return tiles_y.map { |y| 
      return Tile.new((args.state.tile.w * x),
               (args.state.tile.h * y) - args.state.tile.scroll.y,
               if (x*2 == tile_count_x) or (x*2 == tile_count_x - 2)
                 "sprites/tiles/asphalt\ road/road_asphalt01.png"
               else 
                 "sprites/tiles/grass/land_grass11.png"
               end) 
    }
  }

end

def init args
  init_trucks args
  init_tiles args
end
