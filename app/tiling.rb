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
  left.surfaces = []
  left_rect = truck_rect left
  right = args.state.trucks.right
  right.surfaces = []
  right_rect = truck_rect right
  args.state.tiles.each do |r| 
    r.each do |t|
      tile_rect = [t.x, t.y, 128, 128]
      if (tile_rect.intersect_rect? left_rect)
        left.surfaces << t.surface
      elsif (tile_rect.intersect_rect? right_rect)
        right.surfaces << t.surface
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
