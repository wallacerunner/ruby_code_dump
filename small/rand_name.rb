# returns random letters, that looks like two words or even a name
def rand_name
  name = ''
  rand(3..10).times { name += ('a'..'z').to_a.shuffle[0] }
  name += ' '
  rand(3..12).times { name += ('a'..'z').to_a.shuffle[0] }
  name.split(' ').each(&:capitalize!).join(' ')
end

# returns two, ahem, words, that may be interpreted as a name
def random_name
  name = randomize
  name += ' '
  name += randomize
  name.split(' ').each(&:capitalize!).join(' ')
end

# returns random number of random syllables (up to 5 by default) in a form of
# a word
def randomize(syllables_count = 4)
  vow = "aeiouy".split('')
  con = "qwrtpsdfghjklzxcvbnm".split('')
  syllables = []
  (rand(syllables_count) + 1).times do |n|
    syllables[n] = vow.shuffle[0]
    rand(2).times { syllables[n] += con.shuffle[0] }
    syllables[n] = syllables[n].split('').shuffle.join
  end
  syllables.join
end

puts rand_name
puts random_name
