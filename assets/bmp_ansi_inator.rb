# Opens given 24-bit bmp and outputs colors of its pixels as hex into
# pixels.txt. It doesn't check if the file is bmp or else.
bmp = File.open(ARGV[0], "rb")
bmp.pos = 10
bmp.pos = bmp.read(4).unpack("b*").join.reverse.to_i(2)
pix = { :red => [], :green => [], :blue => [] }
until bmp.eof?
    pix[:blue]  << bmp.read(1).unpack("H*")
    pix[:green] << bmp.read(1).unpack("H*")
    pix[:red]   << bmp.read(1).unpack("H*")
end

filename = ARGV[1] || "pixels.txt"
File.open(filename, "w+") do |f|
  pix[:red].length.times do |n|
    f.print "#{[pix[:red][n], pix[:green][n], pix[:blue][n]].join} "
  end
end
