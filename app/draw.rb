def adjust_for_zoom sprite, zoom
  xcenter = 640
  ycenter = 360
  sprite[0] = xcenter - (xcenter - sprite[0]) * zoom
  sprite[1] = ycenter - (ycenter - sprite[1]) * zoom
  sprite[2] *= zoom
  sprite[3] *= zoom
  return sprite
end

def decenterx sprite
  return sprite.x - sprite.w / 2
end

def decentery sprite
  return sprite.y - sprite.h / 2
end

def draw_map args
  zoom = args.state.zoom
  bg = args.state.tiles.map do |r|
     r.map do |t|
       adjust_for_zoom [
         t.x, 
         t.y - args.state.tile.scroll.y,
         128,
         128,
         (image_by_surface t.surface)
       ], zoom
    end
  end

  if args.state.tile.scroll.y >= args.state.tile.h
      args.state.tile.scroll.y = 0
      args.state.tile.jump_occurred = true
  elsif !args.state.paused
    args.state.tile.scroll.y += args.state.speed
  end

  args.outputs.sprites << bg
end

def draw_controls args
  zoom = args.state.zoom
  alpha = [[255, (700 - args.state.tick_count) * 10].min, 0].max
  args.outputs.sprites << (adjust_for_zoom [
    (args.state.trucks.left.x - 10),
    (args.state.trucks.left.y),
    20,
    20,
    'sprites/keyboard_icons/s.png',
    0,
    alpha
  ], zoom)
  args.outputs.sprites << (adjust_for_zoom [
    (args.state.trucks.left.x - 10),
    (args.state.trucks.left.y + 17),
    20,
    20,
    'sprites/keyboard_icons/w.png',
    0,
    alpha
  ], zoom)
  args.outputs.sprites << (adjust_for_zoom [
    (args.state.trucks.left.x - 27),
    (args.state.trucks.left.y),
    20,
    20,
    'sprites/keyboard_icons/a.png',
    0,
    alpha
  ], zoom)
  args.outputs.sprites << (adjust_for_zoom [
    (args.state.trucks.left.x + 7),
    (args.state.trucks.left.y),
    20,
    20,
    'sprites/keyboard_icons/d.png',
    0,
    alpha
  ], zoom)
  args.outputs.sprites << (adjust_for_zoom [
    (args.state.trucks.right.x - 10),
    (args.state.trucks.right.y),
    20,
    20,
    'sprites/keyboard_icons/down.png',
    0,
    alpha
  ], zoom)
  args.outputs.sprites << (adjust_for_zoom [
    (args.state.trucks.right.x - 10),
    (args.state.trucks.right.y + 17),
    20,
    20,
    'sprites/keyboard_icons/up.png',
    0,
    alpha
  ], zoom)
  args.outputs.sprites << (adjust_for_zoom [
    (args.state.trucks.right.x - 27),
    (args.state.trucks.right.y),
    20,
    20,
    'sprites/keyboard_icons/left.png',
    0,
    alpha
  ], zoom)
  args.outputs.sprites << (adjust_for_zoom [
    (args.state.trucks.right.x + 7),
    (args.state.trucks.right.y),
    20,
    20,
    'sprites/keyboard_icons/right.png',
    0,
    alpha
  ], zoom)
end

def draw args
  zoom = args.state.zoom
  truck_left = adjust_for_zoom [
    (decenterx args.state.trucks.left),
    (decentery args.state.trucks.left),
    args.state.trucks.left.w, 
    args.state.trucks.left.h, 
    'sprites/truck.png',
    args.state.trucks.left.rotate
  ], zoom
  truck_right = adjust_for_zoom [ 
    (decenterx args.state.trucks.right), 
    (decentery args.state.trucks.right), 
    args.state.trucks.right.w, 
    args.state.trucks.right.h, 
    'sprites/truck.png',
    args.state.trucks.right.rotate
  ], zoom
  jcvd = adjust_for_zoom [ 
    (decenterx args.state.jcvd), 
    (decentery args.state.jcvd), 
    52, 
    36, 
    'sprites/jcvd.png', 
    args.state.jcvd.rotation
  ], zoom
  foot_left = adjust_for_zoom [ 
    (decenterx args.state.feet.left),
    (decentery args.state.feet.left),
    args.state.feet.left.w, 
    args.state.feet.right.h, 
    'sprites/jcvd-foot.png', 
    args.state.feet.left.rotation
  ], zoom
  foot_right = adjust_for_zoom [ 
    (decenterx args.state.feet.right),
    (decentery args.state.feet.right),
    args.state.feet.right.w,
    args.state.feet.right.h,
    'sprites/jcvd-foot.png',
    args.state.feet.right.rotation
  ], zoom
  leg_left = adjust_for_zoom [ 
    (decenterx args.state.legs.left),
    (decentery args.state.legs.left),
    args.state.legs.left.w,
    args.state.legs.left.h,
    'sprites/pant.png',
    args.state.legs.left.rotation
  ], zoom
  leg_right = adjust_for_zoom [
    (decenterx args.state.legs.right),
    (decentery args.state.legs.right),
    args.state.legs.right.w,
    args.state.legs.right.h,
    'sprites/pant.png',
    args.state.legs.right.rotation
  ], zoom

  draw_map args
  draw_obstacles args
  args.outputs.sprites << truck_left
  args.outputs.sprites << truck_right
  args.outputs.sprites << leg_left
  args.outputs.sprites << leg_right
  args.outputs.sprites << foot_left
  args.outputs.sprites << foot_right
  args.outputs.sprites << jcvd

  draw_controls args

end


