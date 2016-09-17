# For each x in u y = 2 * x + 1 and z = 3 * x + 1, return the n-th element of u
def dbl_linear(n)
  u = [1]
  # Counts how many times each fiber is run
  curr_2 = 0
  curr_3 = 0

  times_2 = Fiber.new do
    u.each do |x|
      u << 2 * x + 1
      curr_2 += 1
      Fiber.yield
    end
  end

  times_3 = Fiber.new do
    u.each do |x|
      u << 3 * x + 1
      curr_3 += 1
      Fiber.yield
    end
  end

  # There are two results of the first function and three results of the
  # second one out of every five results.
  # Other than that - it's total guestimation.
  (5 * n).times do
    times_2.resume
    times_3.resume unless curr_3 * 2 > curr_2 * 3
  end

  u.sort.uniq[n]
end

def dbl_linear_best(n)
    u=[1]
    (0..n*5).each { |i| u << u[i]*2 + 1 << u[i]*3 + 1}
    u.sort.uniq[n]
end
