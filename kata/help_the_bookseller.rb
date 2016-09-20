# Find all the elements in l starting with letter from m and sum their numbers

def stockList(list_of_art, list_of_cat)
  return '' if list_of_art.empty? || list_of_cat.empty?
  res = ''
  list_of_cat.each do |letter|
    amount = 0
    list_of_art.select { |art| art[0] == letter }.each do |art|
      amount += art.scan(/\d+/).join.to_i
    end
    res += ' - ' unless res.empty?
    res += "(#{letter} : #{amount})"
  end
  res
end

def stockList_best(stock_list, categories)
  return "" if stock_list.empty? || categories.empty?

  quantities = Hash.new(0)
  stock_list.each_with_object(quantities) do |item, quantities|
    code, quantity = item.split(" ")
    quantities[code[0]] += quantity.to_i
  end

  categories.map { |category| "(#{category} : #{quantities[category]})" }.join(" - ")
end

def stockList_second(l, m)
  return "" if l.empty? or m.empty?

  result = []
  m.each do |item|
    r = l.select {|c| c =~ /^#{item}/ }.collect {|z| z.split(' ').last.to_i }.reduce(:+)
    result << "(#{item} : #{r || 0})"
  end

  result.join(' - ')
end
