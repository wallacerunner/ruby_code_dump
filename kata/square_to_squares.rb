# Should return array of numbers, sum of squares of which is given n
# I didn't finish it - site kept hanging

def decompose(n)
  squares = []
  results = []
  (1..n).each { |x| squares << x**2 }
  2.upto(squares.length) do |x|
    squares.combination(x).to_a.each do |arr|
      if arr.reduce(:+) == n**2
        results << arr.sort.map { |i| Math.sqrt(i).round }
      end
    end
  end
  results.delete_if { |arr| arr.uniq != arr }
  results.sort_by { |arr| arr.length }.last
end
