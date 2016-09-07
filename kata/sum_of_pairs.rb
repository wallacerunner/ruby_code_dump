# Find the first pair in the 'ints' array, which equals 's', in O(n).
# BTW, I failed it, lol.
def sum_pairs(ints, s)
  pair = [ints.length, ints.length]
  ints.length.times do |i|
    break if i == pair[1]
    ((i + 1)...pair[1]).each do |j|
      if ints[i] + ints[j] == s
        pair = [i, j]
        break
      end
    end
  end

  if !(pair[0] == pair[1])
    [ints[pair[0]], ints[pair[1]]]
  else
    nil
  end
end

def sum_pairs_smart(ints, s)
  seen = {}
  ints.length.times do |n|
    if !seen["#{s - ints[n]}"]
      seen["#{ints[n]}"] = true
    else
      return [ints[n], s - ints[n]].reverse
    end
  end
  nil
end

def sum_pairs_best(ints, s)
  seen = {}
  for i in ints do
    return [s-i, i] if seen[s-i]
    seen[i] = true
  end
  nil
end
