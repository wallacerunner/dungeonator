# TODO: extract draw_screen_from_pixels_array method

require 'tk'
require_relative 'defs'

def show_title
    root = TkRoot.new {
    title "Dungeon-inator!"
    iconphoto Icon
    padx 0
    pady 0
    minsize 640, 480
    resizable false, false
  }
  screen = TkCanvas.new(root){
    width 640
    height 480
    bd 0
    bg 'black'
  }.place(x: 0, y: 0)

  # Open file and draw lots of blocks with colors from it
  pix = File.open("dungeonator/pixels.txt")
  60.times do |y|
    80.times do |x|
      color = "##{pix.read(6)}"
      pix.pos += 1
      TkcText.new(
                  screen,
                  x * Charw,
                  480 - y * Charh,
                  text: AcBlock,
                  tag: "#{x}-#{y}",
                  fill: color,
                  font: Font
                  )
    end
  end

  # Draw copyright
  copyright_text = "Created by WR (c) 2016"
  copyright_location_x = (Txcols / 2) * Charw
  copyright_location_y = (Txrows - 4) * Charh
  TkcText.new(
              screen,
              copyright_location_x,
              copyright_location_y,
              text: copyright_text,
              tag: 'copyright',
              fill: 'yellow',
              font: Font
  )

  Tk.mainloop
end
