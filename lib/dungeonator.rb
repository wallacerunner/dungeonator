# TODO: disable numpad on start or implement support of it being on - it IS a keypress modifier

require "./dungeonator/defs"
require "./dungeonator/utils"
require "./dungeonator/interface_sdl"
require "./dungeonator/menu"
require "./dungeonator/character"

screen = Screen.new
screen.draw_background("../assets/title.bmp")
text = "Art by MS, Code by WR (c) 2016"
x = Utils.centered_x(text)
y = (Txrows - 4) * Charh
screen.write(text, x, y, Yellow)
text = "press <Enter> to start"
x = Utils.centered_x(text)
y = (Txrows - 2) * Charh
screen.write(text, x, y, Yellow)
loop { break if screen.get_keypress == [13, 0] }
# sleep 10
case selected_item = Menu.menu(screen)
when 0
  # Start new game
  screen.input("Enter your name:")
when 1
  # Load saved game
when 2
  # Print instructions
end


loop { break if screen.get_keypress == [13, 0] }
