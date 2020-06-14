def handleInputs args
  left = args.state.trucks.left
  right = args.state.trucks.right
  yspeed = 4
  xspeed = 2


  if args.inputs.keyboard.key_held.w
    left.y += yspeed
    if truck_hit_truck? left, right or (left.y + left.h/2 > args.state.screen.h)
      left.y -= yspeed
    end
  end

  if args.inputs.keyboard.key_held.s
    left.y -= yspeed
    if (truck_hit_truck? left, right)
      left.y += yspeed
    end

  end

  if args.inputs.keyboard.key_held.a
    left.x -= xspeed
    if (truck_hit_truck? left, right) or (left.x - left.w/2 < 0)
      left.x += xspeed
    end
  end

  if args.inputs.keyboard.key_held.d
    left.x += xspeed
    if (truck_hit_truck? left, right) or (left.x + left.w/2 > args.state.screen.w)
      left.x -= xspeed
    end
  end


  if args.inputs.keyboard.key_held.up
    right.y += yspeed
    if (truck_hit_truck? right, left) or (right.y + right.h/2 > args.state.screen.h)
      right.y -= yspeed
    end
  end

  if args.inputs.keyboard.key_held.down
    right.y -= yspeed
    if truck_hit_truck? right, left
      right.y += yspeed
    end
  end

  if args.inputs.keyboard.key_held.left
    right.x -= xspeed
    if (truck_hit_truck? right, left) or (right.x - right.w/2 < 0)
      right.x += xspeed
    end
  end

  if args.inputs.keyboard.key_held.right
    right.x += xspeed
    if (truck_hit_truck? right, left) or (right.x + right.w/2 > args.state.screen.w)
      right.x -= xspeed
    end
  end


end
