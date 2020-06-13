def decenter sprite
  return [sprite.x - sprite.w / 2, sprite.y - sprite.h / 2]
end

def updateJcvd args
  args.state.jcvd.w ||= 52
  args.state.jcvd.h ||= 36
  args.state.jcvd.x = ((args.state.trucks.left.x + args.state.trucks.right.x) / 2)
  args.state.jcvd.y = ((args.state.trucks.left.y + args.state.trucks.right.y) / 2) + 60

  args.state.legs.left.h = 8
  args.state.legs.right.h = 8

  args.state.legs.left.x = ((args.state.trucks.left.x + args.state.jcvd.x) / 2)
  args.state.legs.left.y = ((args.state.trucks.left.y + args.state.jcvd.y) / 2)
  args.state.legs.right.x = ((args.state.trucks.right.x + args.state.jcvd.x) / 2)
  args.state.legs.right.y = ((args.state.trucks.right.y + args.state.jcvd.y) / 2)

  leg_length = Math.sqrt(
    ((args.state.trucks.left.x - args.state.jcvd.x)**2) +
    ((args.state.trucks.left.y - args.state.jcvd.y)**2))

  args.state.legs.left.w = leg_length
  args.state.legs.right.w = leg_length

  left_leg_rotation = Math.atan(
    (args.state.jcvd.y - args.state.trucks.left.y) /
    (args.state.jcvd.x - args.state.trucks.left.x)) * 180 / Math::PI
  
  right_leg_rotation = Math.atan(
    (args.state.trucks.right.y - args.state.jcvd.y) /
    (args.state.trucks.right.x - args.state.jcvd.x)) * 180 / Math::PI

  leg_left = [ args.state.trucks.left.x, args.state.trucks.left.y, args.state.legs.left.w, args.state.legs.left.h, 'sprites/pant.png', left_leg_rotation ]
  leg_right = [ args.state.jcvd.x, args.state.jcvd.y, args.state.legs.right.w, args.state.legs.right.h, 'sprites/pant.png', right_leg_rotation ]

#  args.outputs.sprites << leg_left
# args.outputs.sprites << leg_right

end

