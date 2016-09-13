# Returns index of an element that splits array into halves with equal sums of
# elements
def find_even_index(arr)
  arr.each_index do |i|
    return i if arr[0...i].reduce(:+).to_i == arr[i + 1..arr.length].reduce(:+).to_i
  end
  -1
end

def find_even_index_best(ary)
  0.upto(ary.length).select{|l| ary[0..l].reduce(:+) == ary[l..-1].reduce(:+)}.first || -1
end

def find_even_index_clever(arr)
  left_sum = 0
  right_sum = arr.reduce(:+)

  arr.each_with_index do |e, ind|
    right_sum -= e

    return ind if left_sum == right_sum

    left_sum += e
  end

  -1
end
