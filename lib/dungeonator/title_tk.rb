# TODO: rewrite copyright (and possibly everything else) to use text in canvas

require 'tk'
require './dungeonator/defs'

def show_title
  root = TkRoot.new {
    title "Dungeon-inator!"
    padx 0
    pady 0
    bg "black"
    minsize 640, 480
    maxsize 640, 480
  }

  # Open file and draw lots of blocks with colors from it
  pix = File.open("dungeonator/pixels.txt")
  60.times do |y|
    80.times do |x|
      color = "##{pix.read(6)}"
      pix.pos += 1
      TkLabel.new(root) do
        text $acBlock
        font size: 8
        fg color
        bd 0
        padx 0
        pady 0
      end.place(x: (x * $charw), y: 472 - (y * $charh))
    end
  end

  # Draw copyright
  copyright_text = "Created by WR (c) 2016"
  copyright_location_x = ($txcols / 2 - copyright_text.length / 2) * $charw
  copyright_location_y = ($txrows - 4) * $charh
  TkLabel.new(root) do
    text copyright_text
    fg 'yellow'
    bg 'black'
    font family: 'TkFixedFont', size: 8
    bd 0
  end.place(x: copyright_location_x, y: copyright_location_y)
  Tk.mainloop
end
