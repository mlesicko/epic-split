def makeFeet args
  args.state.feet.left.w ||= 19
  args.state.feet.left.h ||= 13
  args.state.feet.right.w ||= 19
  args.state.feet.right.h ||= 13

<<<<<<< Updated upstream
  args.state.feet.left.x = args.state.trucks.left.x + 30
  args.state.feet.left.y = args.state.trucks.left.y + 80
  args.state.feet.right.x = args.state.trucks.right.x - 30
=======
  args.state.feet.left.x = args.state.trucks.left.x
  args.state.feet.left.y = args.state.trucks.left.y + 80
  args.state.feet.right.x = args.state.trucks.right.x
>>>>>>> Stashed changes
  args.state.feet.right.y = args.state.trucks.right.y + 80

  args.state.feet.left.rotation = args.state.jcvd.rotation
  args.state.feet.right.rotation = args.state.jcvd.rotation + 180
end

def makeLegs args
  args.state.legs.left.h ||= 8
  args.state.legs.right.h ||= 8

  leg_length = Math.sqrt(
    ((args.state.feet.left.x - args.state.jcvd.x)**2) +
    ((args.state.feet.left.y - args.state.jcvd.y)**2))
  
  args.state.legs.left.w = leg_length
  args.state.legs.right.w = leg_length

  args.state.legs.left.rotation = Math.atan(
    (args.state.jcvd.y - args.state.feet.left.y) /
    (args.state.jcvd.x - args.state.feet.left.x)) * 180 / Math::PI
  
  args.state.legs.right.rotation = Math.atan(
    (args.state.feet.right.y - args.state.jcvd.y) /
    (args.state.feet.right.x - args.state.jcvd.x)) * 180 / Math::PI

  args.state.legs.left.x = ((args.state.feet.left.x + args.state.jcvd.x) / 2)
  args.state.legs.left.y = ((args.state.feet.left.y + args.state.jcvd.y) / 2)
  args.state.legs.right.x = ((args.state.feet.right.x + args.state.jcvd.x) / 2)
  args.state.legs.right.y = ((args.state.feet.right.y + args.state.jcvd.y) / 2)
end

def updateJcvd args
<<<<<<< Updated upstream
=======
  args.state.jcvd.w ||= 52
  args.state.jcvd.h ||= 36
>>>>>>> Stashed changes
  args.state.jcvd.x = ((args.state.trucks.left.x + args.state.trucks.right.x) / 2)
  args.state.jcvd.y = ((args.state.trucks.left.y + args.state.trucks.right.y) / 2) + 80
  args.state.jcvd.rotation = Math.atan2(
    (args.state.trucks.left.y - args.state.trucks.right.y),
    (args.state.trucks.left.x - args.state.trucks.right.x)
  ) * 180 / Math::PI

  makeFeet args
  makeLegs args
end

