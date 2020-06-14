def render_credit args, x, y, text, size, color
  black = [0, 0, 0]
  args.outputs.labels << [x+2, y-2, text, size, 1, *black, 255, "fonts/CompassGold.ttf"]
  args.outputs.labels << [x, y, text, size, 1, *color,  255, "fonts/CompassGold.ttf"]
end


def render_attribution args, title, link, license
  black = [0, 0, 0]
  white = [255, 255, 255]
  yellow = [255, 255, 100]
  args.outputs.labels << [args.state.screen.w - 20, 90, title, -3, 2, *yellow,  255, "fonts/CompassGold.ttf"]
  args.outputs.labels << [args.state.screen.w - 20, 75, "Link: " + link, -3, 2, *white,  255, "fonts/CompassGold.ttf"]
  args.outputs.labels << [args.state.screen.w - 20, 60, "License: " + license, -3, 2, *white,  255, "fonts/CompassGold.ttf"] if license
end



def play_credits args
  white = [255, 255, 255]
  yellow = [255, 255, 100]
  center_x = args.state.screen.w/2
  case args.state.tick_count
  when (60..240)
    render_credit args, center_x, 565, "A", 8, white
    render_credit args, center_x, 535, "LoggerDale", 18, yellow
    render_credit args, center_x, 475, "Production", 8, white
  when (360..580)
    render_credit args, center_x, 535, "Epic Split", 18, yellow
    render_credit args, center_x, 475, "How to Stretch Your Inner Thigh", 8, white
  when (720..840)
    render_attribution args, "Deliberate Thought by Kevin McCloud", "https://incompetech.filmmusic.io/song/3635-deliberate-thought", "http://creativecommons.org/licenses/by/4.0/"
  when (960..1080)
    render_attribution args, "Kenney Game Assets 1", "https://kenney.itch.io/kenney-game-assets-1", "Public Domain"
  when (1200..1320)
    render_attribution args, "Compass Bold by Eeve Somepx", "https://somepx.itch.io/humble-fonts-golda", "http://www.palmentieri.it/somepx/license.txt"
  when (1440..1560)
    render_attribution args, "Made in DragonRuby", "https://dragonruby.itch.io/dragonruby-gtk", nil
  when (1680..1800)
    render_attribution args, "How to Stetch Your Inner Thighs on WikiHow", "https://www.wikihow.life/Stretch-Your-Inner-Thighs", nil
  when (1920..2040)
    render_attribution args, "Made for the Random WikiHow Jam", "https://itch.io/jam/random-wikihow-jam", nil

  end


end
