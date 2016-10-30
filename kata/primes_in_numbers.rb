require 'prime'

# Finds the prime factor decomposition for given number.
# There is the same "prime_division" method in "mathn" library.
def primeFactors(n)
  Prime.prime_division(n).map do |x|
    if x[1] > 1
      "(#{x[0]}**#{x[1]})"
    else
      "(#{x[0]})"
    end
  end.join
end
