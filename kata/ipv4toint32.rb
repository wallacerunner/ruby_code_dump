# Take IPv4 address, convert every octet of it to binary, join and covert the
# result into an integer
def ip_to_int32(ip)
  ip.split('.').map { |octet| octet.to_i.to_s(2).
  prepend('0' * (8 - octet.to_i.to_s(2).length)) }.join.to_i(2)
end

require 'ipaddr'
def ip_to_int32_require(ip)
  x = IPAddr.new(ip).to_i
end

def ip_to_int32_reduce(ip)
  ip.split( '.' ).reduce( 0 ) { |total, p| total * 256 + p.to_i }
end

def ip_to_int32_division(ip)
  ("%02x%02x%02x%02x" % ip.split('.')).to_i(16)
end
