# Break string on camelCases - insert spaces in front of upcases
def solution(string)
  string.gsub(/([A-Z])/, ' \1')
end

# In best practices parentheses after 'gsub' are omitted
