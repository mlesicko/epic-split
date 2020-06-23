def tree x, y
  return {x: x,
          y: y,
          w: 141,
          h: 141,
          img: "sprites/objects/tree.png"}
end

def rock x, y
  return {x: x,
          y: y,
          w: 89,
          h: 72,
          img: "sprites/objects/rock.png"}
end

def barrel x, y
  return {x: x,
          y: y,
          w: 56,
          h: 56,
          img: "sprites/objects/barrel.png"}
end

def oil x,y
  return {x: x,
          y: y,
          w: 109,
          h: 95,
          img: "sprites/objects/oil.png"}
end

def crate x,y
  return {x: x,
          y: y,
          w: 70,
          h: 70,
          img: "sprites/objects/crate.png"}
end

def cactus x,y
  return {x: x,
          y: y,
          w: 70,
          h: 110,
          img: "sprites/objects/cactus.png"}
end

def lava_jet1 x,y
  return {x: x,
          y: y,
          w: 47,
          h: 47,
          img: "sprites/objects/lava_jet1.png"}
end

def lava_jet2 x,y
  return {x: x,
          y: y,
          w: 112,
          h: 124,
          img: "sprites/objects/lava_jet2.png"}
end

def lava_jet3 x,y
  return {x: x,
          y: y,
          w: 106,
          h: 124,
          img: "sprites/objects/lava_jet3.png"}
end

def key x,y
  return {x: x,
          y: y,
          w: 60,
          h: 36,
          img: "sprites/objects/key.png"}
end

def keyboard_key l,x,y
  return {x: x,
          y: y,
          w: 60,
          h: 60,
          img: "sprites/keyboard_icons/"+l+".png"}
end

def present x,y
  return {x: x,
          y: y,
          w: 70,
          h: 70,
          img: "sprites/objects/present.png"}
end

def smoke x,y
  return {x: x,
          y: y,
          w: 100,
          h: 100,
          img: "sprites/objects/smoke.png"}
end

def fish x,y
  return {x: x,
          y: y,
          w: 55,
          h: 41,
          img: "sprites/objects/fish.png"}
end

def boat x,y
  return {x: x,
          y: y,
          w: 94,
          h: 74,
          img: "sprites/objects/boat.png"}
end

def detect_ob_surfaces x, y, args
  surfaces = []
  point = [x + 10, y, 20, 0]
  args.state.tiles.each do |r|
    r.each do |t|
      tile_rect = [t.x, t.y, 128, 128]
      if (tile_rect.intersect_rect? point)
        surfaces << t.surface
      end
    end
  end
  return surfaces
end


def ob_by_surface x, y, args
  surfaces = detect_ob_surfaces x, y, args
  if surfaces.include? "road"
    get_road_ob x, y, args
  elsif surfaces.include? "grass"
    get_grass_ob x, y, args
  elsif surfaces.include? "dirt"
    get_dirt_ob x, y, args
  elsif surfaces.include? "desert"
    get_desert_ob x, y, args
  elsif surfaces.include? "snow"
    get_snow_ob x, y, args
  elsif surfaces.include? "water"
    get_water_ob x, y, args
  elsif surfaces.include? "videogame"
    get_videogame_ob x, y, args
  elsif surfaces.include? "hell"
    get_hell_ob x, y, args
  elsif surfaces.include? "void"
    get_void_ob x, y, args
  else
    return nil
  end
end

def get_road_ob x, y, args
  value = rand
  if rand < 0.33
    return oil x, y
  elsif rand < 0.66
    return barrel x, y
  else
    return nil
  end
end

def get_grass_ob x, y, args
  if (rand > 0.5) 
    return tree x, y 
  else
    return rock x, y 
  end
end

def get_dirt_ob x, y, args
  return rock x, y
end

def get_desert_ob x, y, args
  if (rand > 0.67) 
    return cactus x, y 
  else
    return rock x, y 
  end
end

def get_snow_ob x, y, args
  if (rand > 0.2) 
    return rock x, y 
  else
    return present x, y 
  end
end

def get_water_ob x, y, args
  if (rand > 0.5) 
    return fish x, y 
  else
    return boat x, y 
  end
end

def get_videogame_ob x, y, args
  value = rand
  if value < 0.6
    return crate x, y 
  elsif value < 0.84
    return key x, y
  elsif value < 0.86
    return keyboard_key "w", x, y
  elsif value < 0.88
    return keyboard_key "a", x, y
  elsif value < 0.90
    return keyboard_key "s", x, y
  elsif value < 0.92
    return keyboard_key "d", x, y
  elsif value < 0.94
    return keyboard_key "up", x, y
  elsif value < 0.96
    return keyboard_key "down", x, y
  elsif value < 0.98
    return keyboard_key "left", x, y
  else
    return keyboard_key "right", x, y
  end
end

def get_hell_ob x, y, args
  value = rand
  if value < 0.3
    return lava_jet1 x, y 
  elsif value < 0.67
    return lava_jet2 x, y
  else
    return lava_jet3 x, y 
  end
end

def get_void_ob x, y, args
  return smoke x, y
end

def spawn_obstacle args
  if (args.state.opening_done && rand > (0.996 - (args.state.speed / 500)))
    x = (args.state.screen.w - 64) * rand
    y = args.state.screen.h + 64
    obstacle = ob_by_surface x, y, args
    if obstacle
      args.state.obstacles << args.state.new_entity(:obstacle, obstacle)
    end
  end
end

def scroll_obstacles args
  args.state.obstacles.each do |o|
    o.y -= args.state.speed
  end

  args.state.obstacles = args.state.obstacles.select do |o|
    o.y > -200
  end
end

def draw_obstacles args
  obs = args.state.obstacles.map do |o| 
    [o.x, o.y, o.w, o.h, o.img]
  end
  args.outputs.sprites << obs
end



def truck_hit_obstacle? args, truck
  rect = truck_rect truck
  small_rect = [rect[0]+ 10, rect[1] - 10 + (rect[3]*1/3), rect[2] - 20, rect[3] * 2/3]
  return args.state.obstacles.reduce(false) do |hit, ob|
    ob_rect = [ob.x + 10, ob.y + 10, ob.w - 20, ob.h - 20]
    hit or (ob_rect.intersect_rect? small_rect)
  end
end
