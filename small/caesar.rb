def caesar_ord(line, shift)
  lowercase_letters = ('a'..'z').to_a
  uppercase_letters = ('A'..'Z').to_a
  line.split('').map do |char|
    if lowercase_letters.include?(char)
      if lowercase_letters.include?((char.ord + shift).chr)
        char = (char.ord + shift).chr
      else
        if shift > 0
          char = (char.ord - 26 + shift).chr
        else
          char = (char.ord + 26 + shift).chr
        end
      end
    elsif uppercase_letters.include?(char)
      if uppercase_letters.include?((char.ord + shift).chr)
        char = (char.ord + shift).chr
      else
        if shift > 0
          char = (char.ord - 26 + shift).chr
        else
          char = (char.ord + 26 + shift).chr
        end
      end
    else
      char
    end
  end.
  join

end

def caesar_hash(line, shift)
  # I want to write a method, that will fill the hash, basing on shift variable,
  # and do it with metaprogramming basics just for the sake of it.

end

puts caesar_ord("test", 3)

# TODO: refactor caesar_ord
#       write caesar_hash
