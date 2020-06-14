def adjust_x_pos_for_zoom x, zoom
  center = 640
  return center - (center - x) * zoom
end

def adjust_y_pos_for_zoom y, zoom
  center = 360
  return center - (center - y) * zoom
end


def decenterx sprite, zoom
  return (adjust_x_pos_for_zoom (sprite.x - sprite.w / 2), zoom)
end

def decentery sprite, zoom
  return (adjust_y_pos_for_zoom (sprite.y - sprite.h / 2), zoom)
end

def draw_map args
  zoom = args.state.zoom
  bg = args.state.tiles.map do |r|
     r.map do |t|
       [
         (adjust_x_pos_for_zoom t.x, zoom), 
         (adjust_y_pos_for_zoom (t.y - args.state.tile.scroll.y), zoom),
         128 * zoom,
         128 * zoom,
         (image_by_surface t.surface)
       ]
    end
  end

  if args.state.tile.scroll.y >= args.state.tile.h
      args.state.tile.scroll.y = 0
  else
    args.state.tile.scroll.y += 1
  end

  args.outputs.sprites << bg
end

def draw args
  zoom = args.state.zoom
  truck_left = [
    (decenterx args.state.trucks.left, zoom),
    (decentery args.state.trucks.left, zoom),
    args.state.trucks.left.w * zoom, 
    args.state.trucks.left.h * zoom, 
    'sprites/truck.png'
  ]
  truck_right = [ 
    (decenterx args.state.trucks.right, zoom), 
    (decentery args.state.trucks.right, zoom), 
    args.state.trucks.right.w * zoom, 
    args.state.trucks.right.h * zoom, 
    'sprites/truck.png'
  ]
  jcvd = [ 
    (decenterx args.state.jcvd, zoom), 
    (decentery args.state.jcvd, zoom), 
    52 * zoom, 
    36 * zoom, 
    'sprites/jcvd2.png', 
    args.state.jcvd.rotation
  ]
  foot_left = [ 
    (decenterx args.state.feet.left, zoom),
    (decentery args.state.feet.left, zoom),
    args.state.feet.left.w * zoom, 
    args.state.feet.right.h * zoom, 
    'sprites/jcvd-foot.png', 
    args.state.feet.left.rotation
  ]
  foot_right = [ 
    (decenterx args.state.feet.right, zoom),
    (decentery args.state.feet.right, zoom),
    args.state.feet.right.w * zoom,
    args.state.feet.right.h * zoom,
    'sprites/jcvd-foot.png',
    args.state.feet.right.rotation
  ]
  leg_left = [ 
    (decenterx args.state.legs.left, zoom),
    (decentery args.state.legs.left, zoom),
    args.state.legs.left.w * zoom,
    args.state.legs.left.h * zoom,
    'sprites/pant.png',
    args.state.legs.left.rotation
  ]
  leg_right = [
    (decenterx args.state.legs.right, zoom),
    (decentery args.state.legs.right, zoom),
    args.state.legs.right.w * zoom,
    args.state.legs.right.h * zoom,
    'sprites/pant.png',
    args.state.legs.right.rotation
  ]

  draw_map args
  args.outputs.sprites << truck_left
  args.outputs.sprites << truck_right
  args.outputs.sprites << leg_left
  args.outputs.sprites << leg_right
  args.outputs.sprites << foot_left
  args.outputs.sprites << foot_right
  args.outputs.sprites << jcvd
  args.outputs.borders << [* (truck_rect args.state.trucks.left)]
  args.outputs.borders << [* (truck_rect args.state.trucks.right)]
  args.outputs.labels << [40, 40, args.state.trucks.left.surfaces[0]]
  args.outputs.labels << [80, 40, args.state.trucks.right.surfaces[0]]
end


