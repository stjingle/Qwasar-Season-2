require 'date'
def my_data_transform(csv_content)
    csv_array = csv_content.split(/\n/)
    csv_head = csv_array[0].split(',')
    csv_body = csv_array[1..csv_array.length-1]
    csv_result = []
    index_of_mail = csv_head.index('Email')
    index_of_age = csv_head.index('Age')
    index_of_order = csv_head.index('Order At')
    csv_result << csv_head.join(",")
    csv_body.each{|data_array|
        array = data_array.split(',') 
        rs = []
        array.each{|data|
            dt = data
            dt = set_email(data) if array.index(data) == index_of_mail
            dt = set_age(data) if array.index(data) == index_of_age
            dt = set_order_at(data) if array.index(data) == index_of_order
            rs << dt
        }
        csv_result << rs.join(',')
    }
    return csv_result
end
def set_email(email)
    return email.split('@')[1]
end
def set_age(age)
    case age.to_i
    when 1..20
        return "1->20"
    when 21..40
        return "21->40" 
    when 41..65
        return "41->65"
    when 66..99
        return "66->99"
    end
end
def set_order_at(order_at)
    dt = DateTime.parse(order_at, '%Y-%m-%d %H:%M:%S')
    hour = dt.hour.to_i
    case hour
    when 6..11
        return "morning"
    when 12..17
        return "afternoon"
    when 18..23
        return "evening"
    end
end
# my_data_transform "Gender,FirstName,LastName,UserName,Email,Age,City,Device,Coffee Quantity,Order At\nMale,Carl,Wilderman,carl,wilderman_carl@yahoo.com,29,Seattle,Safari iPhone,2,2020-03-06 16:37:56\nMale,Marvin,Lind,marvin,marvin_lind@hotmail.com,77,Detroit,Chrome Android,2,2020-03-02 13:55:51\nFemale,Shanelle,Marquardt,shanelle,marquardt.shanelle@hotmail.com,21,Las Vegas,Chrome,1,2020-03-05 17:53:05\nFemale,Lavonne,Romaguera,lavonne,romaguera.lavonne@yahoo.com,81,Seattle,Chrome,2,2020-03-04 10:33:53\nMale,Derick,McLaughlin,derick,mclaughlin.derick@hotmail.com,47,Chicago,Chrome Android,1,2020-03-05 15:19:48\n"require 'date'
def my_data_transform(csv_content)
    csv_array = csv_content.split(/\n/)
    csv_head = csv_array[0].split(',')
    csv_body = csv_array[1..csv_array.length-1]
    csv_result = []
    index_of_mail = csv_head.index('Email')
    index_of_age = csv_head.index('Age')
    index_of_order = csv_head.index('Order At')
    csv_result << csv_head.join(",")
    csv_body.each{|data_array|
        array = data_array.split(',') 
        rs = []
        array.each{|data|
            dt = data
            dt = set_email(data) if array.index(data) == index_of_mail
            dt = set_age(data) if array.index(data) == index_of_age
            dt = set_order_at(data) if array.index(data) == index_of_order
            rs << dt
        }
        csv_result << rs.join(',')
    }
    return csv_result
end
def set_email(email)
    return email.split('@')[1]
end
def set_age(age)
    case age.to_i
    when 1..20
        return "1->20"
    when 21..40
        return "21->40" 
    when 41..65
        return "41->65"
    when 66..99
        return "66->99"
    end
end
def set_order_at(order_at)
    dt = DateTime.parse(order_at, '%Y-%m-%d %H:%M:%S')
    hour = dt.hour.to_i
    case hour
    when 6..11
        return "morning"
    when 12..17
        return "afternoon"
    when 18..23
        return "evening"
    end
end