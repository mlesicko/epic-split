def handleInputs args
  left = args.state.trucks.left
  right = args.state.trucks.right
  keyboard = args.inputs.keyboard
  controller = args.inputs.controller_one
  left_keys = {
    up: keyboard.key_held.w,
    down: keyboard.key_held.s,
    left: keyboard.key_held.a,
    right: keyboard.key_held.d
  }
  left_stick = {
    x: controller.left_analog_x_perc,
    y: controller.left_analog_y_perc
  }
  right_keys = {
    up: keyboard.key_held.up,
    down: keyboard.key_held.down,
    left: keyboard.key_held.left,
    right: keyboard.key_held.right
  }
  right_stick = {
    x: controller.right_analog_x_perc,
    y: controller.right_analog_y_perc
  }


  if args.state.opening_done
    handle_movement left, left_keys, left_stick, args
    handle_movement right, right_keys, right_stick, args
  end
end

def handleSystemInputs args
  if args.inputs.keyboard.key_down.p
     args.state.paused = !args.state.paused
  end
  if args.inputs.keyboard.key_down.m
     args.state.muted = !args.state.muted
  end
end

def handle_movement truck, keys, stick, args
    if keys[:up] || stick[:y] >= 0.5
      truck_forward truck, args
    end

    if keys[:down] || stick[:y] <= -0.5
      truck_backward truck, args
    end

    if keys[:left] || stick[:x] <= -0.5
      truck_left truck, args
    else
      truck_passive_rotate_right truck, args
    end

    if keys[:right] || stick[:x] >= 0.5
      truck_right truck, args
    else
      truck_passive_rotate_left truck, args
    end
end

def truck_forward truck, args
  truck.y += yspeed args
  if (truck_collision? args) or (truck.y + truck.h/2 > args.state.screen.h)
    truck.y -= yspeed args
  end
end

def truck_backward truck, args
  truck.y -= yspeed args
  if (truck_collision? args)
    truck.y += yspeed args
  end
end

def truck_left truck, args
  truck.x -= xspeed args
  if truck.rotate < (max_turn args)
    truck.rotate += turning_rate args
  end
  if (truck_collision? args) or (truck.x - truck.w/2 < 0)
    truck.x += xspeed args
    if truck.rotate > 0
      truck.rotate -= (turning_rate args) * 2
    end
  end
end

def truck_right truck, args
  truck.x += xspeed args
  if truck.rotate > -(max_turn args)
    truck.rotate -= turning_rate args
  end
  if (truck_collision? args) or (truck.x + truck.w/2 > args.state.screen.w)
    truck.x -= xspeed args
    if truck.rotate < 0
      truck.rotate += (turning_rate args) * 2
    end
  end
end

def truck_passive_rotate_right truck, args
  if truck.rotate > 0
    truck.rotate -= (turning_rate args)* 2
  end
end

def truck_passive_rotate_left truck, args
  if truck.rotate < 0
    truck.rotate += (turning_rate args)* 2
  end
end

def xspeed args
  return 2
end

def yspeed args
  return 3 + args.state.speed
end

def turning_rate args
  return 0.5
end

def max_turn args
  return 9
end

def truck_collision? args 
  left = args.state.trucks.left
  right = args.state.trucks.right
  truck_hit_truck? right, left
end
