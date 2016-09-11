require 'tk'
def show_title
  root = TkRoot.new {
    title "Dungeon-inator!"
    padx 0
    pady 0
    bg "black"
    minsize 640, 480
    maxsize 640, 480
  }
  pix = File.open("dungeonator/pixels.txt")
  60.times do |y|
    80.times do |x|
      color = "##{pix.read(6)}"
      pix.pos += 1
      TkLabel.new(root) do
        text "█"
        font size: 8
        fg color
        bd 0
        padx 0
        pady 0
      end.place(x: (x * 8), y: 472 - (y * 8))
    end
  end
  Tk.mainloop
end
