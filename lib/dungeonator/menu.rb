module Menu

  @menu_items = ['new ', 'load', 'instructions', 'quit']

  def self.draw_menu(selected_index)
    @menu_items.each_index do |index|
      text = @menu_items[index].capitalize
      x = Utils.centered_x(@menu_items[index])
      y = (Txrows / 2 + 12 + index * 4) * Charh + 3
      if selected_index == index
        @screen.write(text, x, y, White)
      else
        @screen.write(text, x, y, Gray)
      end
    end
  end

  def self.menu(screen)
    @screen = screen
    screen.draw_background("../assets/menu.bmp")
    text = "Dungeonator "
    x = Utils.centered_x(text)
    y = (Txrows / 2 + 4) * Charh
    screen.write(text, x + 1, y + 1, Black, 'bold')
    screen.write(text, x, y, Yellow, 'bold')
    text = "ver. #{Version}"
    x = Utils.centered_x(text)
    y = (Txrows / 2 + 7) * Charh
    screen.write(text, x, y, Yellow)

    current_pos = 0
    draw_menu(current_pos)

    loop do
      case key = screen.get_keypress
      when [273, 0]
        if current_pos - 1 < 0
          current_pos = @menu_items.length - 1
        else
          current_pos -= 1
        end
        draw_menu(current_pos)
      when [274, 0]
        if current_pos + 1 == @menu_items.length
          current_pos = 0
        else
          current_pos += 1
        end
        draw_menu(current_pos)
      when [13, 0] || [271, 0]
        exit if current_pos == @menu_items.length - 1
        return current_pos
      end
    end
  end

end
