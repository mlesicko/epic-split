require "app/inputs.rb"
require "app/updateJcvd.rb"
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

  handleInputs args
  draw_map args
  updateJcvd args

  truck_left = [ * (decenter args.state.trucks.left), args.state.trucks.left.w, args.state.trucks.left.h, 'sprites/truck.png' ]
  truck_right = [ * (decenter args.state.trucks.right), args.state.trucks.right.w, args.state.trucks.right.h, 'sprites/truck.png' ]
  jcvd = [ * (decenter args.state.jcvd), 52, 36, 'sprites/jcvd.png', 180]
  
  args.outputs.sprites << truck_left
  args.outputs.sprites << truck_right
  args.outputs.sprites << jcvd

end

