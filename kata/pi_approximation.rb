# Calculates Pi using Leibniz formula with epsilon precision compared to Math::PI.
def iter_pi(epsilon)
  pi = 0.0
  n  = 0
  loop do
    pi += (-1)**n / (2.0 * n + 1)
    n += 1
    break if (Math::PI - pi * 4).abs < epsilon
  end
  [n, (pi * 4).round(10)]
end
