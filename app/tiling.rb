def draw_map args
  args.state.screen.w = 1280
  args.state.screen.h = 720
  args.state.tile.w = 128
  args.state.tile.h = 128
  args.state.tile.scroll.y ||= 0
  
  tile_count_x = (args.state.screen.w / args.state.tile.w).to_i
  tile_count_y = (args.state.screen.h / args.state.tile.h).to_i 
  tiles_x = (0..tile_count_x).to_a
  tiles_y= (0..tile_count_y + 1).to_a
  grass= tiles_x.map { |x| 
    tiles_y.map { |y| 
      [(args.state.tile.w * x),
       (args.state.tile.h * y) - args.state.tile.scroll.y,
       128,
       128, 
       if (x*2 == tile_count_x) or (x*2 == tile_count_x - 2)
         "sprites/tiles/Asphalt\ road/road_asphalt01.png"
      else 
        "sprites/tiles/Grass/land_grass11.png"
      end] 
    }
  }

  if args.state.tile.scroll.y >= args.state.tile.h
      args.state.tile.scroll.y = 0
  else 
    args.state.tile.scroll.y += 1
  end
  args.outputs.sprites << [* grass]
  args.outputs.labels << [0, 0, "!", 4]
end
