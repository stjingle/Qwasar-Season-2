  def my_roman_numerals_converter num
    romnum = ""
  
    REPRESENTATION.each do |change|
      alphab = change[0]
      value = change[1]
      romnum += alphab*(num / value)
      num = num % value
    end
    return romnum
  end
  REPRESENTATION = [
    ["M", 1000], 
    ["D", 500],
  
    ["C", 100], 
    ["L", 50],
    ["XL", 40], 
    ["X", 10],
    ["IX", 9],
    ["VIII", 8],
    ["VI", 6], 
    ["V", 5],
    ["IV", 4],
    ["I", 1], 
  ]