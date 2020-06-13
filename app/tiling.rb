def draw_map args
  bg = args.state.tiles.map do |r| 
     r.map do |t| 
       [t.x, t.y - args.state.tile.scroll.y, 128, 128, t.img]
    end
  end

  if args.state.tile.scroll.y >= args.state.tile.h
      args.state.tile.scroll.y = 0
  else 
    args.state.tile.scroll.y += 1
  end

  args.outputs.sprites << bg
  args.outputs.labels << [0, 0, "!", 4]
end
