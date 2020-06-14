def handleInputs args
  left = args.state.trucks.left
  right = args.state.trucks.right
  yspeed = 3 + args.state.speed
  xspeed = 2

  if args.state.opening_done
    if args.inputs.keyboard.key_held.w || args.inputs.controller_one.left_analog_y_perc >= 0.5
      left.y += yspeed
      if truck_hit_truck? left, right or (left.y + left.h/2 > args.state.screen.h)
        left.y -= yspeed
      end
    end

    if args.inputs.keyboard.key_held.s || args.inputs.controller_one.left_analog_y_perc <= -0.5
      left.y -= yspeed
      if (truck_hit_truck? left, right)
        left.y += yspeed
      end

    end

    if args.inputs.keyboard.key_held.a || args.inputs.controller_one.left_analog_x_perc <= -0.5
      left.x -= xspeed
      if (truck_hit_truck? left, right) or (left.x - left.w/2 < 0)
        left.x += xspeed
      end
    end

    if args.inputs.keyboard.key_held.d || args.inputs.controller_one.left_analog_x_perc >= 0.5
      left.x += xspeed
      if (truck_hit_truck? left, right) or (left.x + left.w/2 > args.state.screen.w)
        left.x -= xspeed
      end
    end


    if args.inputs.keyboard.key_held.up || args.inputs.controller_one.right_analog_y_perc >= 0.5
      right.y += yspeed
      if (truck_hit_truck? right, left) or (right.y + right.h/2 > args.state.screen.h)
        right.y -= yspeed
      end
    end

    if args.inputs.keyboard.key_held.down || args.inputs.controller_one.right_analog_y_perc <= -0.5
      right.y -= yspeed
      if truck_hit_truck? right, left
        right.y += yspeed
      end
    end

    if args.inputs.keyboard.key_held.left || args.inputs.controller_one.right_analog_x_perc <= -0.5
      right.x -= xspeed
      if (truck_hit_truck? right, left) or (right.x - right.w/2 < 0)
        right.x += xspeed
      end
    end

    if args.inputs.keyboard.key_held.right || args.inputs.controller_one.right_analog_x_perc >= 0.5
      right.x += xspeed
      if (truck_hit_truck? right, left) or (right.x + right.w/2 > args.state.screen.w)
        right.x -= xspeed
      end
    end
  end

end
