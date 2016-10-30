string = ARGV[0]

# Abbreviate words into -> "A8e w3s i2o"
def abbreviate(string)
  string.scan(/\w+/).map do |word|
    if word.length > 3
      abr_word = word[0] + (word.length - 2).to_s + word[-1]
      string = string.sub(word, abr_word)
    end
  end
  string
end

def best_abbreviate(string)
  string.gsub /(\w)(\w+{2})(\w)/ do |word|
    "#{$1}#{word.length - 2}#{$3}"
  end
end
