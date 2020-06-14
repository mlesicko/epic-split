def choose_surface args, x, y
  if (x * 2 == args.state.tile_count_x) or (x * 2 == args.state.tile_count_x - 2)
    return "road"
  else
    return "grass"
  end
end

def image_by_surface surface_type
  case surface_type  
  when "grass"
    return "sprites/tiles/grass/land_grass11.png"
  when  "road"
    return "sprites/tiles/asphalt\ road/road_asphalt01.png"
  end
end

def detect_surfaces args
  left = args.state.trucks.left
  left_rect = [left.x, left.y, left.x + left.w, left.y - left.h]
  right = args.state.trucks.right
  right_rect = [right.x, right.y, right.x + right.w, right.y - right.h]
  args.state.tiles.each do |r| 
    r.each do |t|
      tile_rect = [t.x, t.y, t.x + 128, t.x + 128]
      if tile_rect.intersects_rect? left_rect
        args.state.trucks.left.surface = t.surface
      elsif tile_rect.intersects_rect? right_rect
        args.state.trucks.right.surface = t.surface
      end
    end
  end
end

def draw_map args
  bg = args.state.tiles.map do |r| 
     r.map do |t| 
       [t.x, t.y - args.state.tile.scroll.y, 128, 128, (image_by_surface t.surface)]
    end
  end

  if args.state.tile.scroll.y >= args.state.tile.h
      args.state.tile.scroll.y = 0
  else 
    args.state.tile.scroll.y += 1
  end

  args.outputs.sprites << bg
end
