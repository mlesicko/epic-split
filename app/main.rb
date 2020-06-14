require "app/init.rb"
require "app/inputs.rb"
require "app/updateJcvd.rb"
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
end

def tick args
  init args

  handleOpening args

  handleInputs args
  updateJcvd args
  detect_surfaces args

  draw args
end
