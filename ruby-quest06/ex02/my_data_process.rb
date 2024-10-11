require 'json'
def my_data_process(processing)
    header = processing[0].split(',')
    body = processing[1..processing.length-1]
    group = ["Gender","Email","Age","City","Device","Order At"]
    index = 0
    hash = {}
    header.each{|key|
        if(group.include?(key))
            col = []
            body.each{|val| 
                col << val.split(',')[index]
            }
        
            hash[key] = col.group_by(&:itself).transform_values(&:count)
        end
        index +=1
    }
    return hash.to_json
end 