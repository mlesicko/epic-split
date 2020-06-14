require "app/init.rb"
require "app/inputs.rb"
require "app/updateJcvd.rb"
require "app/tiling.rb"

def decenter sprite
  return [sprite.x - sprite.w / 2, sprite.y - sprite.h / 2]
end

def tick args
  init args

  handleInputs args
  updateJcvd args
  detect_surfaces args

  truck_left = [ * (decenter args.state.trucks.left), args.state.trucks.left.w, args.state.trucks.left.h, 'sprites/truck.png' ]
  truck_right = [ * (decenter args.state.trucks.right), args.state.trucks.right.w, args.state.trucks.right.h, 'sprites/truck.png' ]
  jcvd = [ * (decenter args.state.jcvd), 52, 36, 'sprites/jcvd2.png', args.state.jcvd.rotation]
  foot_left = [ * (decenter args.state.feet.left), args.state.feet.left.w, args.state.feet.right.h, 'sprites/jcvd-foot.png', args.state.feet.left.rotation]
  foot_right = [ * (decenter args.state.feet.right), args.state.feet.right.w, args.state.feet.right.h, 'sprites/jcvd-foot.png', args.state.feet.right.rotation]
  leg_left = [ * (decenter args.state.legs.left), args.state.legs.left.w, args.state.legs.left.h, 'sprites/pant.png', args.state.legs.left.rotation ]
  leg_right = [ * (decenter args.state.legs.right), args.state.legs.right.w, args.state.legs.right.h, 'sprites/pant.png', args.state.legs.right.rotation ]

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

