require "app/inputs.rb"
require "app/tiling.rb"

def decenter sprite
  return [sprite.x - sprite.w / 2, sprite.y - sprite.h / 2]
end

def tick args
  args.state.trucks.left.w ||= 88
  args.state.trucks.left.h ||= 218
  args.state.trucks.right.w ||= 88
  args.state.trucks.right.h ||= 218
  
  args.state.trucks.left.x ||= 520
  args.state.trucks.left.y ||= 310
  args.state.trucks.right.x ||= 650
  args.state.trucks.right.y ||= 310
  args.state.jcvd.w ||= 52
  args.state.jcvd.h ||= 36
  args.state.jcvd.x = ((args.state.trucks.left.x + args.state.trucks.right.x) / 2)
  args.state.jcvd.y = ((args.state.trucks.left.y + args.state.trucks.right.y) / 2) + 60
  
  handleInputs args
  draw_map args

  truck_left = [ * (decenter args.state.trucks.left), args.state.trucks.left.w, args.state.trucks.left.h, 'sprites/truck.png' ]
  truck_right = [ * (decenter args.state.trucks.right), args.state.trucks.right.w, args.state.trucks.right.h, 'sprites/truck.png' ]
  jcvd = [ * (decenter args.state.jcvd), 52, 36, 'sprites/character_black_white.png', 180]
  
  args.outputs.sprites << truck_left
  args.outputs.sprites << truck_right
  args.outputs.sprites << jcvd

end

