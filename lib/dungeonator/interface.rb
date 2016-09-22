
class Screen

  def initialize
    new_window
    new_screen
    @objects = []
    # update
  end

  def draw_background(source)
    file = File.open(source)
    file.pos = 10
    file.pos = file.read(4).unpack("b*").join.reverse.to_i(2)
    pixel = {}
    60.times do |y|
      80.times do |x|
        pixel[:blue]  = file.read(1).unpack("H*")
        pixel[:green] = file.read(1).unpack("H*")
        pixel[:red]   = file.read(1).unpack("H*")
        color = "##{[pixel[:red], pixel[:green], pixel[:blue]].join}"
        @screen.itemconfigure "#{x}-#{60 - y}", fill: color
      end
    end
  end

  def title
    draw_background("../assets/title.bmp")
    copyright_text = "Created by WR (c) 2016"
    copyright_location_x = (Txcols / 2) * Charw
    copyright_location_y = (Txrows - 4) * Charh
    write(copyright_text, copyright_location_x, copyright_location_y)
    write("Press <Enter> to start...", copyright_location_x, (Txrows - 2) * Charh)
    # @root.bind("Return", main_menu)
    update
  end

  def main_menu
    clear_screen
    draw_background("../assets/menu.bmp")
    # print out menu
    # define menu logic

  end

  def write(text, x, y)
    text = TkcText.new(
                @screen,
                x,
                y,
                text: text,
                tag: 'copyright',
                fill: 'yellow',
                font: Font
    )
    @objects << text
  end

  def clear_screen
    @objects.each { |object| object.destroy }
  end

  private

    def update
      @root.update
    end

    def new_window
      @root = TkRoot.new {
        title "Dungeon-inator!"
        iconphoto Icon
        padx 0
        pady 0
        minsize 645, 484
        resizable false, false
      }
    end

    def new_screen
      @screen = TkCanvas.new(@root){
        width 640
        height 480
        bd 0
        bg 'black'
      }.place(x: 0, y: 0)

      60.times do |y|
        80.times do |x|
          TkcText.new(
                      @screen,
                      x * Charw + Charw / 2,
                      480 - y * Charh,
                      text: AcBlock,
                      tag: "#{x}-#{60 - y}",
                      font: Font
                      )
        end
      end
    end

end
