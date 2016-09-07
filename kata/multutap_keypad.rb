# Counts presses needed to enter given phrase on an old phone's keypad
def presses(phrase)
  letters_per_button = [' 0', '1', 'abc2', 'def3', 'ghi4', 'jkl5', 'mno6',
                        'pqrs7', 'tuv8', 'wxyz9']

  phrase.downcase.split('').map do |letter|
    letters_per_button.map do |button|
      button.index(letter) + 1 if button.index(letter)
    end
  end.flatten.compact.reduce(:+)
end

def presses_best(phrase)
  groups = ["1", " 0", "ABC2", "DEF3", "GHI4", "JKL5", "MNO6", "TUV8", "PQRS7", "WXYZ9"]
  phrase.upcase.chars.map do |c|
    1 + groups.find { |grp| grp.include?(c) }.index(c)
  end.reduce(:+)
end
