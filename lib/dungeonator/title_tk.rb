# TODO: delete this file
# TODO: try instance vars with modules
# TODO: figure out how to switch between bindings (tk)
# TODO: find if tk can use fonts from file

require 'tk'
require 'tkextlib/tile'
# require_relative 'defs'

# def show_title
    $root = TkRoot.new {
    title "Dungeon-inator!"
    # iconphoto Icon
    padx 0
    pady 0
    # minsize 640, 480
    resizable false, false
  }
  # screen = TkCanvas.new($root){
  #   width 640
  #   height 480
  #   bd 0
  #   # bg 'black'
  # }.place(x: 0, y: 0)

  # Open file and draw lots of blocks with colors from it
  # pix = File.open("dungeonator/pixels.txt")
  # 60.times do |y|
  #   80.times do |x|
  #     color = "##{pix.read(6)}"
  #     pix.pos += 1
  #     TkcText.new(
  #                 screen,
  #                 x * Charw,
  #                 480 - y * Charh,
  #                 text: AcBlock,
  #                 tag: "#{x}-#{y}",
  #                 fill: color,
  #                 font: Font
  #                 )
  #   end
  # end

  # Draw copyright
  # copyright_text = "Created by WR (c) 2016"
  # copyright_location_x = (80 / 2) * 8
  # copyright_location_y = (60 - 4) * 8
  # l = TkcText.new(
  #             screen,
  #             copyright_location_x,
  #             copyright_location_y,
  #             text: copyright_text,
  #             tag: 'copyright',
  #             fill: 'yellow',
  #             # font: Font
  # )
  l = TkLabel.new($root) {text "Starting..."}.grid
  $l_2 = Tk::Tile::Label.new($root) {text ""}.grid
  # l.bind("Enter") {l['text'] = "Moved mouse inside"}
  def do_something_to(key)
    case key
    when "Up"
      $root['bg'] = 'yellow'
    when "Down"
      $root['bg'] = 'black'
    else
      $l_2['text'] += key
    end
    # key_pressed = false
  end
  other_proc = proc { |k|
    case k
    when 'b'
      l['bg'] = 'black'
    when 'w'
      l['bg'] = 'white'
    end
    if k == "Up"
      $root.bind("KeyPress", the_proc, '%K')
    end
  }
  the_proc = proc { |k|
    l['text'] = "#{k}"
    # do_something_to(k)
    # key = k
    # key_pressed = true
    $l_2['text'] += k
    if k == "Return"
      $root.bind("KeyPress", other_proc, '%K')
    end
  }
  $root.bind("KeyPress", the_proc, '%K')
  # $root.bind("Up") { l['text'] = "You pressed Up" }
  # l.bind("B3-Motion", proc{|x,y| l['text'] = "right button drag to #{x} #{y}"}, "%x %y")
  # l.bind("1") {l['text'] = "Clicked left mouse button"}
  Tk.mainloop
