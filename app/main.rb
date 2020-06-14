require "app/init.rb"
require "app/inputs.rb"
require "app/updateJcvd.rb"
require "app/collision.rb"
require "app/obstacles.rb"
require "app/tiling.rb"
require "app/draw.rb"

def handleOpening args
  args.state.opening_done ||= false
  args.state.zoom ||= 20
  if args.state.opening_done == false
    args.state.zoom -= 0.05
  end
  if args.state.zoom <= 1
    args.state.zoom = 1
    args.state.opening_done = true
  end
end

def tick args
  init args
  spawn_obstacle args
  scroll_obstacles args

  handleOpening args

  handleInputs args
  updateJcvd args
  detect_surfaces args

  draw args
  if args.state.trucks.left.surfaces.include? "grass"
    args.state.trucks.left.y -= 1
  end

  if args.state.trucks.right.surfaces.include? "grass"
    args.state.trucks.right.y -= 1
  end

  args.outputs.borders << [* (truck_rect args.state.trucks.left)]
  args.outputs.borders << [* (truck_rect args.state.trucks.right)]
  args.outputs.labels << [40, 80, (truck_hit_obstacle? args, args.state.trucks.left).to_s]
  args.outputs.labels << [40, 40, (truck_hit_obstacle? args, args.state.trucks.right).to_s]
  args.outputs.labels << [40, 120, args.state.obstacles.length.to_s]
end
