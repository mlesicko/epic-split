def tick args
  args.outputs.labels << [ 580, 500, 'Hello World!']
  args.outputs.labels << [ 475, 150, '(Consider reading README.txt now.)']

  truckw = 88
  truckh = 218

  truck1x = 520
  truck1y = 310
  truck2x = 650
  truck2y = 310
  jcvdw = 52
  jcvdh = 36
  jcvdx = ((truck1x + truck2x) / 2)
  jcvdy = ((truck1y + truck2y) / 2)

  if args.inputs.keyboard.key_down.w
    args.state.h_pressed_at = args.state.tick_count
  end

  truck1 = [ truck1x - truckw/2 , truck1y - truckh/2, truckw, truckh, 'sprites/truck.png' ]
  truck2 = [ truck2x - truckw/2, truck2y - truckh/2, truckw, truckh, 'sprites/truck.png' ]
  jcvd = [ jcvdx - jcvdw/2, jcvdy - jcvdh/2, 52, 36, 'sprites/character_black_white.png', 180]
  
  args.outputs.sprites << truck1
  args.outputs.sprites << truck2
  args.outputs.sprites << jcvd

end

