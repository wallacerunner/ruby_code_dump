def array_to_bmp(data_array, vocabulary)
  bmp = Bitmap.new()
  data_array.each do |data_block|
    vocabulary << data_block: Color.new if !(vocabulary.find(data_block))
    bmp.pixels << vocabulary(data_block)
  end
  bmp.write
end
