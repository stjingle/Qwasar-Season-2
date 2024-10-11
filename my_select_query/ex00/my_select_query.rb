class MySelectQuery
    
    #  Constructor
    def initialize(csv_content)
        @csv = csv_content.split("\n")

    end

    # Function to search CSV data
    def where(column_name, criteria)
        headings = @csv[0].split(",")
        for i in 0..headings.length - 1
            if headings[i] == column_name
                idx = i
                break
            end
        end

        result = []

        for i in 1..@csv.length - 1
            line = @csv[i].split(",")
            if line[idx] == criteria
                result[result.length] = @csv[i]
            end
        end

        return result
    end

end
