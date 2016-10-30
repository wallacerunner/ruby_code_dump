# This one is pretty much the same as the parity_outlier.rb, except the indexes
# returned has to start from 1
def iq_test(numbers)
  numbers = numbers.split(' ').map(&:to_i)
  numbers.index(numbers.partition(&:odd?).find(&:one?).first) + 1
end

def iq_test_best(numbers)
  nums = numbers.split.map(&:to_i).map(&:even?)
  nums.count(true) > 1 ? nums.index(false) + 1 : nums.index(true) + 1
end
