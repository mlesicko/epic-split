def choose_surface args, x, y
  if (x * 2 == args.state.tile_count_x) or (x * 2 == args.state.tile_count_x - 2)
    return "road"
  else
    return get_level 0
  end
end

def image_by_surface surface_type
  case surface_type  
  when "grass"
    return "sprites/tiles/grass.png"
  when  "road"
    return "sprites/tiles/road.png"
  when  "dirt"
    return "sprites/tiles/dirt.png"
  when  "desert"
    return "sprites/tiles/sand.png"
  when  "snow"
    return "sprites/tiles/snow.png"
  when "water"
    return "sprites/tiles/water.png"
  when "videogame"
    return "sprites/tiles/stone.png"
  when "hell"
    return "sprites/tiles/lava.png"
  when "void"
    return "sprites/tiles/void.png"
  end
end

def get_level i
  levels = [
    "grass",
    "dirt",
    "desert",
    "snow",
    "water",
    "videogame",
    "hell",
    "void"
  ]
  return levels[i % (levels.length())]
end

def update_biome args
  level_length = 20 * 60 # TODO: make this longer
  if !(args.state.running_time.is_a? Numeric)
     scroll_into_biome args, (get_level 0)
  else
     scroll_into_biome args, (get_level (args.state.running_time / level_length).to_i)
  end
end

def scroll_into_biome args, biome
  for row in args.state.tiles.reverse()
    if row[0].surface == biome
      next
    end
    if args.state.tile.jump_occurred
      for tile in row
        if tile.surface != "road"
          tile.surface = biome
        end
      end
      args.state.tile.jump_occurred = false
    end
    break
  end
end

def reset_biome args
  set_biome args, (get_level 0)
end

def set_biome args, biome
  for row in args.state.tiles
    for tile in row
      if tile.surface != "road"
        tile.surface = biome
      end
    end
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

