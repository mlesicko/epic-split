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
  args.state.lost_at ||= args.state.tick_count
  args.outputs.sprites.clear
  args.outputs.solids << [0, 0, args.state.screen.w, args.state.screen.h]
  lose_delta = (args.state.tick_count - args.state.lost_at)
  case lose_delta
  when 0
    args.outputs.sounds << "sounds/tires.wav"
  when 45
    args.outputs.sounds << "sounds/crash.wav"
  when 300
    args.state.trucks.left.x = nil
    args.state.trucks.left.y = nil
    args.state.trucks.right.x = nil
    args.state.trucks.right.y = nil
    args.state.obstacles = []

    args.state.lost_at = nil
  end
end 

def tick args
  init args
  spawn_obstacle args
  if args.state.lost_at
    scroll_obstacles args

    handleOpening args

    handleInputs args
    updateJcvd args
    detect_surfaces args

    args.outputs.sounds << "sounds/music.ogg"

    draw args
    if args.state.trucks.left.surfaces.include? "grass"
      args.state.trucks.left.y -= 1
    end

    if args.state.trucks.right.surfaces.include? "grass"
      args.state.trucks.right.y -= 1
    end
  end

  if (truck_hit_obstacle? args, args.state.trucks.left) or (truck_hit_obstacle? args, args.state.trucks.right)
    lose_game args
  end
end
