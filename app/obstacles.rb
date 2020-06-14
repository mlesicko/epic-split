def tree x, y
  return {x: x,
          y: y,
          w: 141,
          h: 141,
          img: "sprites/objects/tree_small.png"}
end

def rock x, y
  return {x: x,
          y: y,
          w: 89,
          h: 72,
          img: "sprites/objects/rock1.png"}
end

def barrel x, y
  return {x: x,
          y: y,
          w: 56,
          h: 56,
          img: "sprites/objects/barrel_blue.png"}
end

def oil x,y
  return {x: x,
          y: y,
          w: 109,
          h: 95,
          img: "sprites/objects/oil.png"}
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
    if (rand < 0.5)
      return oil x, y
    else
      return barrel x, y
    end
  else
    if (rand > 0.5) 
      return tree x, y 
    else
      return rock x, y 
    end
  end
end

def spawn_obstacle args
  if (args.state.opening_done && rand > 0.995)
    x = (args.state.screen.w - 64) * rand
    y = args.state.screen.h + 64
    args.state.obstacles << args.state.new_entity(:obstacle,
                                                  (ob_by_surface x, y, args))
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
