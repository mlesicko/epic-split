def handleInputs args
  left = args.state.trucks.left
  right = args.state.trucks.right
  yspeed = 4
  xspeed = 2


  if args.inputs.keyboard.key_held.w
    left.y += yspeed
    if truck_hit_truck? 
  end

  if args.inputs.keyboard.key_held.s
    args.state.trucks.left.y -= yspeed
  end

  if args.inputs.keyboard.key_held.a
    args.state.trucks.left.x -= xspeed
  end

  if args.inputs.keyboard.key_held.d
    left.x += xspeed
    if truck_hit_truck? left right
      left.x -= xspeed
    end
  end


  if args.inputs.keyboard.key_held.up
    args.state.trucks.right.y += yspeed
  end

  if args.inputs.keyboard.key_held.down
    args.state.trucks.right.y -= yspeed
  end

  if args.inputs.keyboard.key_held.left
    args.state.trucks.right.x -= xspeed
  end

  if args.inputs.keyboard.key_held.right
    args.state.trucks.right.x += xspeed
  end


end

