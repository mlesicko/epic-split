def init_trucks args
  args.state.trucks.left.w ||= 88
  args.state.trucks.left.h ||= 218
  args.state.trucks.right.w ||= 88
  args.state.trucks.right.h ||= 218
  
  args.state.trucks.left.x ||= args.state.screen.w/2 - args.state.trucks.left.w/2
  args.state.trucks.left.y ||= 270
  args.state.trucks.right.x ||= args.state.screen.w/2 + args.state.trucks.right.w/2
  args.state.trucks.right.y ||= 270
end

def init_tiles args
  args.state.tile.w ||= 128
  args.state.tile.h ||= 128
  args.state.tile.scroll.y ||= 0
  
  args.state.tile_count_x = (args.state.screen.w / args.state.tile.w).to_i
  args.state.tile_count_y = (args.state.screen.h / args.state.tile.h).to_i 
  tiles_x = (0..args.state.tile_count_x).to_a
  tiles_y = (0..args.state.tile_count_y + 1).to_a
  args.state.tiles ||= tiles_x.map do |x| 
    tiles_y.map do |y| 
      args.state.new_entity(:tile,
                            { x: (args.state.tile.w * x),
                              y: (args.state.tile.h * y) - args.state.tile.scroll.y,
                              surface: choose_surface(args, x, y)})
    end
  end

end

def init args
  args.state.screen.w ||= 1280
  args.state.screen.h ||= 720
  args.state.jcvd.w ||= 52
  args.state.jcvd.h ||= 36
  args.state.obstacles ||= []
  args.state.speed ||= 1
  args.state.start_time ||= args.state.tick_count
  args.state.running_time ||= 0
  init_trucks args
  init_tiles args
end
