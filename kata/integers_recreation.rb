# Returns an array of arrays containing numbers, which sum of squares of
# divisors is a square number itself, with those square numbers.

require 'prime'

def list_squared(m, n)
  m.upto(n).map do |number|
    a = 1
    if Prime.prime?(number)
      a += number**2
    else
      primes = []
      Prime.prime_division(number).each { |i|
        (1..i[1]).each { |j|
          primes << i[0]**j
        }
      }

      primes.each_index { |i|
        (i...primes.length).each { |j|
          mul = primes[i] * primes[j]
          primes << mul if number % (mul) == 0 && !primes.include?(mul)
        }
      }

      primes.each { |i| a += i**2 }
    end
    [number, a] if Math::sqrt(a).round**2 == a
  end.compact
end


require 'set'

def list_squared_best(m, n)
  (m..n).map do |num|
    divisors = Set.new((1..Math.sqrt(num)).select { |d| num % d == 0 })
    divisors += divisors.map { |d| num / d }

    sum_sq_divisors = divisors.map { |d| d * d }.inject(:+)
    [num, sum_sq_divisors] if Math.sqrt(sum_sq_divisors) % 1 == 0
  end.compact
end
