
require 'sdl'

class Screen

  def initialize
    SDL.init(SDL::INIT_VIDEO)
    SDL::TTF.init
    @font = SDL::TTF.open(Font, 8)
    SDL::WM.icon = SDL::Surface.load_bmp(Icon)
    width = Txcols * Charw
    height = Txrows * Charh
    @screen = SDL::Screen.open(width, height, 0, SDL::SWSURFACE)
    SDL::WM.set_caption("Dungeonator!", "D-i!")
    @saved_screen_state = []
  end

  # Draws background from given 80x60 bitmap
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

  # Writes string at given coords with given color. Options are 'bold' & 'italic'
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

  # Creates input window with title
  def input(title)
    save_screen_state
    draw_input_window(title)

    line = ''
    loop do
      key = get_keypress
      case key
      when nil
        next
      when [8, 0]
        line.chop!
      when [27, 0]
        return nil
      when [13, 0]#, [271, 0]
        break if !line.empty?
      end
      line += handle_as_text(key)
      draw_input_window(title)
      x = (Txcols / 2 - title.length / 2 - 1) * Charw
      y = (Txrows / 2 - 1) * Charh

#FIXME if input width is changed from depending on title.length
      if line.length + 1 >= title.length + 2
        write(line[-(title.length + 1)..-1] + '_', x, y, White)
      else
        write(line + '_', x, y, White)
      end
    end

    restore_screen_state
    return line
  end

  private

    # Currently: draws input window in the center, width based on title.length
    def draw_input_window(title)
      width = (title.length + 4) * Charw
      height = Charh * 5
      x = Txcols * Charw / 2 - width / 2
      y = Txrows * Charh / 2 - height / 2 - 4
      @screen.fill_rect(x, y, width, height, Gray)
      @screen.fill_rect(x + 3, y + 3, width - 6, height - 6, Black)
      @screen.fill_rect(x + 5, y + 5, width - 10, height - 10, Gray)
      x_text = Utils.centered_x(title)
      y_text = y
      f_r, f_g, f_b = Yellow
      b_r, b_g, b_b = Gray
      @font.draw_shaded_utf8(@screen, title, x_text, y_text, f_r, f_g, f_b, b_r, b_g, b_b)
      @screen.update_rect(x, y, width, height)
    end

    # Saves current screen state to a new surface on top of the stack of saved
    # screen states
    def save_screen_state
      @saved_screen_state << create_surface
      @saved_screen_state.last.put(@screen, 0, 0)
    end

    # Restores saved screen state from the top of the stack
    def restore_screen_state
      @screen.put(@saved_screen_state.pop, 0, 0)
      @screen.update_rect(0, 0, 0, 0)
    end

    # Creates a surface with screen's parameters
    def create_surface
      format = @screen.format
      SDL::Surface.new(SDL::SWSURFACE, @screen.w, @screen.h, format.bpp,
                       format.Rmask, format.Gmask, format.Bmask, format.Amask)
    end

    # Interprets keypresses as printable chars
    def handle_as_text(key)
      if key[0].between?(44, 57) || key[0].between?(91, 93) ||
         key[0].between?(96, 122) || key[0] == 61 || key[0] == 39 || key[0] == 32
        if key[1] == 0
          return key[0].chr
        elsif key[1].between?(1, 2)
          shifted_keys = {
            32 => ' ',
            39 => '"',
            44 => '<',
            45 => '_',
            46 => '>',
            47 => '?',
            48 => ')',
            49 => '!',
            50 => '@',
            51 => '#',
            52 => '$',
            53 => '%',
            54 => '^',
            55 => '&',
            56 => '*',
            57 => '(',
            61 => '+',
            91 => '{',
            92 => '|',
            93 => '}',
            96 => '~'
          }
          return key[0].chr.upcase if key[0].between?(97, 122)
          return shifted_keys[key[0]]
        end
      end
      return ''
    end

end
