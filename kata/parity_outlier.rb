# Among array of integers find one, which is different - either odd or even
def find_outlier(integers)
  odds = []
  evens = []
  integers.each do |integer|
    odds << integer if integer.odd?
    evens << integer if integer.even?
  end
  odds.length > 1 ? evens[0] : odds[0]
end

def find_outlier_best(integers)
  integers.partition(&:odd?).find(&:one?).first
end
