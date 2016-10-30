# Returns true if all given points are on thesame line, flse otherwise.
def on_line(points)
  return true if points.empty?

  point_1 = points.uniq.first
  point_2 = points.uniq.last
  condition = ''

  if point_1[0] == point_2[0]
    condition = "point[0] != point_1[0]"
  elsif point_1[1] == point_2[1]
    condition = "point[1] != point_1[1]"
  elsif point_1[0] == point_1[1] && point_2[0] == point_2[1]
    condition = "point[0] != point[1]"
  else
    k = (point_2[1] - point_1[1]) / (point_2[0] - point_1[0]).to_f
    b = point_1[1].to_f - k * point_1[0]
    condition = "point[1] != (k * point[0] + b).round"
  end

  points.each do |point|
    return false if eval(condition)
  end

  true
end

def on_line_best(points)
  points.uniq.each_cons(2).map {|p1, p2| (p2[1] - p1[1]).to_f / (p2[0] - p1[0]).to_f }.uniq.length.between?(0,1)
end
