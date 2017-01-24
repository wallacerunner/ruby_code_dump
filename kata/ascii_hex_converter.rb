module Converter
  def self.to_ascii(hex)
    hex.split.pack('H*')
  end

  def self.to_hex(ascii)
    ascii.chars.map { |ch| ch.unpack('H*') }.join
  end
end

module Converter_best
  def self.to_ascii(hex)
    [hex].pack("H*")
  end

  def self.to_hex(ascii)
   ascii.unpack("H*")[0]
  end
end
