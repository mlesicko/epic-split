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

def cone x, y
end

def barrel x, y
end



def ob_by_surface x, y, args
 if (rand > 0.5) 
   return tree x, y 
 else
   return rock x, y 
 end
end

def spawn_obstacle args
  if (rand > 0.995)
    x = (args.state.screen.w - 64) * rand
    y = args.state.screen.h + 64
    args.state.obstacles << args.state.new_entity(:obstacle,
                                                  (ob_by_surface x, y, args))
  end
end

def scroll_obstacles args
  args.state.obstacles.each do |o|
    o.y -= 1
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
  return args.state.obstacles.reduce(false) do |hit, ob|
    ob_rect = [ob.x, ob.y, ob.w, ob.h]
    args.outputs.borders << [*ob_rect]
    hit or (ob_rect.intersect_rect? rect)
  end
end