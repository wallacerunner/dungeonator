# TODO: deal with vars vivsibility - I need screen to be visible in here

module Utils

  def self.draw_background(source, screen)
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
        screen.itemconfigure "#{x}-#{60 - y}", fill: color
      end
    end
  end

end
