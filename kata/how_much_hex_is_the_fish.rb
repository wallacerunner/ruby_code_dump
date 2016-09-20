# Returns XOR of hex letters in given string
def fisHex(name)
  name.scan(/[abcdef]/i).map { |letter| letter.to_i(16) }.reduce(:^) || 0
end

def fisHex_best(name)
  name.scan(/\h/).map(&:hex).inject(0, :^)
end
