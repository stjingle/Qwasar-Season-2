def my_is_sort(param_1)
    arrangement = false
    sorted = param_1.clone.sort
    if param_1 == sorted
      arrangement = true
    elsif param_1 == sorted.reverse
      arrangement = true
    end
    return arrangement
  end