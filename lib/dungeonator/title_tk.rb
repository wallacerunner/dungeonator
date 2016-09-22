# TODO: delete this file
# TODO: try instance vars with modules
# TODO: figure out how to switch between bindings (tk)

require 'tk'
$root = TkRoot.new {
                    title "Dungeon-inator!"
                    padx 0
                    pady 0
                    minsize 645, 484
                    resizable false, false
                   }
screen = TkCanvas.new($root){
                              width 640
                              height 480
                              bd 0
                              bg 'black'
                            }.place(x: 0, y: 0)

l = TkLabel.new($root) {text "Starting..."}.grid
$l_2 = Tk::Tile::Label.new($root) {text ""}.grid

def binding(n)
  $l_2['text'] = n
end

$root.bind("KeyPress", proc {|k| binding(k) }, '%K')
Tk.mainloop
