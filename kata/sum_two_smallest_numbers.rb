# Return sum of two smallest numbers in given array
def sum_two_smallest_numbers(numbers)
  numbers.sort[0, 2].reduce(:+)
end

def sum_two_smallest_numbers_best(numbers)
  numbers.min(2).reduce(:+)
end
