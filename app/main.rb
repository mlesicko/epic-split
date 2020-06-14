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
  case args.state.tick_count
  when (60..240)
    args.outputs.labels << [args.state.screen.w/2+2, 563, "A", 8, 1, 0, 0, 0, 255, "fonts/CompassGold.ttf"]
    args.outputs.labels << [args.state.screen.w/2, 565, "A", 8, 1, 255, 255, 255, 255, "fonts/CompassGold.ttf"]
    args.outputs.labels << [args.state.screen.w/2+2, 533, "LoggerDale", 18, 1, 0, 0, 0, 255, "fonts/CompassGold.ttf"]
    args.outputs.labels << [args.state.screen.w/2, 535, "LoggerDale", 18, 1, 255, 255, 100, 255, "fonts/CompassGold.ttf"]
    args.outputs.labels << [args.state.screen.w/2+2, 473, "Production", 8, 1, 0, 0, 0, 255, "fonts/CompassGold.ttf"]
    args.outputs.labels << [args.state.screen.w/2, 475, "Production", 8, 1, 255, 255, 255, 255, "fonts/CompassGold.ttf"]
  when (360..580)
    args.outputs.labels << [args.state.screen.w/2+2, 533, "Epic Split", 18, 1, 0, 0, 0, 255, "fonts/CompassGold.ttf"]
    args.outputs.labels << [args.state.screen.w/2, 535, "Epic Split", 18, 1, 255, 255, 100, 255, "fonts/CompassGold.ttf"]
    args.outputs.labels << [args.state.screen.w/2+2, 473, "How to Stretch Your Inner Thighs", 8, 1, 0, 0, 0, 255, "fonts/CompassGold.ttf"]
    args.outputs.labels << [args.state.screen.w/2, 475, "How to Stretch Your Inner Thighs", 8, 1, 255, 255, 255, 255, "fonts/CompassGold.ttf"]
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
    args.state.speed = nil
    args.state.start_time = nil
    args.state.running_time = nil

    args.state.lost_at = nil
  end
end 

def ticks_to_time ticks
  totalSeconds =  (ticks / 60).to_i
  totalMinutes = (totalSeconds / 60).to_i
  remainderSeconds = totalSeconds - (totalMinutes * 60)
  return totalMinutes.to_s + ":" + remainderSeconds.to_s.rjust(2, "0")
end

def tick args
  init args
  spawn_obstacle args
  if !args.state.lost_at
    scroll_obstacles args

    handleOpening args

    handleInputs args
    updateJcvd args
    detect_surfaces args

    # args.outputs.sounds << "sounds/music.ogg"

    draw args
    if (args.state.trucks.left.surfaces.include? "grass") and !(truck_hit_truck? args.state.trucks.left, args.state.trucks.right)
        args.state.trucks.left.y -= args.state.speed
    end

    if args.state.trucks.right.surfaces.include? "grass" and !(truck_hit_truck? args.state.trucks.right, args.state.trucks.left)
      args.state.trucks.right.y -= args.state.speed
    end
  end

  args.state.running_time = args.state.tick_count - args.state.start_time  
  args.state.speed = 1 + (args.state.running_time / 1800).to_i

  args.outputs.labels << [40, 80, (ticks_to_time args.state.running_time), 3, 1, 255, 255, 100, 255, "fonts/CompassGold.ttf"]
  
=begin
  if (truck_hit_obstacle? args, args.state.trucks.left) or 
      (truck_hit_obstacle? args, args.state.trucks.right) or
      (args.state.trucks.left.y < -105) or
      (args.state.trucks.right.y < -105)
    lose_game args
  end
=end
end
