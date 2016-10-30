# Take every digit and raise it to the power of 2
def square_digits num
  num.to_s.split('').map { |n| n.to_i**2 }.join.to_i
end

def square_digits_best num
  num.to_s.chars.map{|x| x.to_i**2}.join.to_i
end
