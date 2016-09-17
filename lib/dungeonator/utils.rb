#TODO: deal with vars vivsibility - I need screen to be visible in here

module Utils

  def self.draw_background(source, screen)
    file = File.open(source)
    60.times do |y|
      80.times do |x|
        color = "##{file.read(6)}"
        file.pos += 1
        screen.itemconfigure "#{x}-#{60 - y}", fill: color
      end
    end
  end

end
