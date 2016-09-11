# I was horsing around with Shoes a little.
# This script opens "pixels.txt", which is the result of bmp_ansi_inator.rb,
# and outputs it as hella-lotta squares of corresponding colors.
Shoes.app( title: "Dungeon-inator",
  width: 640, height: 480, resizable: false) do
    background black
    @pr = para ""
    @pr.style size: 8, margin: 0, stroke: white
    pix = File.open("pixels.txt")
    # color = []
    60.times do
      80.times { |x|
        color_hex = pix.read(6)
        # color << Shoes::rgb("ff".to_i(16),"ff".to_i(16),"ff".to_i(16))
        # @pr.style stroke: colr
        # @pr.text += "█"
        pix.pos += 1
        # @pr.style stroke: rgb(250, 250, 250), size: 20
        # @pr.text += "█" * 3
        para "█", stroke: color_hex, size: 8, margin: 0
        # para "#{color_hex}", stroke: color_hex
      }
    end
end
