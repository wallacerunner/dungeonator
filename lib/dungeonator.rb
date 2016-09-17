# TODO: break into separate pieces, split into files

# require "./dungeonator/title_tk"
require 'tk'
require "./dungeonator/utils"
require "./dungeonator/defs"

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

60.times do |y|
  80.times do |x|
    TkcText.new(
                screen,
                x * Charw,
                480 - y * Charh,
                text: AcBlock,
                tag: "#{x}-#{60 - y}",
                font: Font
                )
  end
end

Utils.draw_background("../assets/title", screen)

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
sleep 5
Utils.draw_background("../assets/menu", screen)

Tk.mainloop
