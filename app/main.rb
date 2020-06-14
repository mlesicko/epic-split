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

def lose_game args
  args.state.trucks.left.x = nil
  args.state.trucks.left.y = nil
  args.state.trucks.right.x = nil
  args.state.trucks.right.y = nil
  args.state.obstacles = []
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

  if (truck_hit_obstacle? args, args.state.trucks.left) or (truck_hit_obstacle? args, args.state.trucks.right)
    lose_game args
  end
end
