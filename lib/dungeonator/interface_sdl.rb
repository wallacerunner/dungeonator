# TODO: Complete 'input' method

require 'sdl'

class Screen

  def initialize
    SDL.init(SDL::INIT_VIDEO)
    SDL::TTF.init
    @font = SDL::TTF.open(Font, 16)
    SDL::WM.icon = SDL::Surface.load_bmp(Icon)
    width = Txcols * Charw
    height = Txrows * Charh
    @screen = SDL::Screen.open(width, height, 0, SDL::SWSURFACE)
    SDL::WM.set_caption("Dungeonator!", "D-i!")
  end

  def draw_background(source)
    file = File.open(source)
    file.pos = 10
    file.pos = file.read(4).unpack("b*").join.reverse.to_i(2)
    pixel = {}
    60.times do |y|
      80.times do |x|
        pixel[:blue]  = file.read(1).unpack("H*")[0].to_i(16)
        pixel[:green] = file.read(1).unpack("H*")[0].to_i(16)
        pixel[:red]   = file.read(1).unpack("H*")[0].to_i(16)
        @font.draw_solid_utf8(@screen, AcBlock, x * Charw, (59 - y) * Charh,
                              pixel[:red], pixel[:green], pixel[:blue])
      end
    end
    @screen.update_rect(0,0,0,0)
  end

  def write(string, x, y, color, *args)
    @font.style = SDL::TTF::STYLE_BOLD if args.include?('bold')
    @font.style = SDL::TTF::STYLE_ITALIC if args.include?('italic')
    r, g, b = color
    @font.draw_solid_utf8(@screen, string, x, y, r, g, b)
    @screen.update_rect(0,0,0,0)
    @font.style = SDL::TTF::STYLE_NORMAL
  end

  def get_keypress
    loop do
      event = SDL::Event.poll
      case event
      when SDL::Event::Quit
        exit
      when SDL::Event::KeyDown
        return event.sym, event.mod
      when nil
        return nil
      end
    end
  end

  def clear_screen
    @screen.fill_rect(0, 0, 640, 480, 0)
    @screen.update_rect(0, 0, 0, 0)
  end

  def input(title)
    width = (title.length + 4) * Charw
    height = Charh * 6
    x = Txcols * Charw / 2 - width / 2
    y = Txrows * Charh / 2 - height / 2
    @screen.fill_rect(x, y, width, height, Gray)
    @screen.fill_rect(x + 6, y + 6, width - 12, height - 12, Black)
    @screen.fill_rect(x + 8, y + 8, width - 16, height - 16, Gray)
    x_text = Utils.centered_x(title)
    y_text = y
    f_r, f_g, f_b = Yellow
    b_r, b_g, b_b = Gray
    @font.draw_shaded_utf8(@screen, title, x_text, y_text, f_r, f_g, f_b, b_r, b_g, b_b)
    @screen.update_rect(x, y, width, height)

    # loop
    #   if get_keypress == [13, 0]
    #     return entered string
    #   end
    #   if Esc { somehow return screen to previous state }
    #   get char
    #   print it
    #   add to string
    # end


  end

end

=begin
screen = Screen.new
screen.draw_background("../../assets/title.bmp")
screen.write("test test", 640 / 2 - 10, 480 - 16, 255, 255, 0)
loop do
  case a = screen.get_keypress
  when [32, 1]
    break
  when [102, 64]
    screen.clear_screen
  when nil
  else
    print "#{a[0]}, #{a[1]}\n"
  end
end
=end
