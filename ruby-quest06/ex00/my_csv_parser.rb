def my_csv_parser(param_1, param_2)
    data_array = param_1.split()
    csv = data_array.map do |line| 
          line.split(param_2)
    end
    return csv
end