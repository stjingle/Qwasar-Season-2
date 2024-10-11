def my_string_index(haystack, needle)

    index = -1
    for str in 0..haystack.length-1 do
        if haystack[str] == needle
            index = str
            break
        end
    end
    return index

end
