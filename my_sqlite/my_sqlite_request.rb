require 'csv'

class MySqliteRequest
  def initialize
    @query_Request_Mode_ = :none
    @NaMe_of_TablE_ = nil
    @where_FilTer = []
    @Which_CoLumn = []
    @Which_OrdeR = nil
    @Join_InfoRmation = nil
    @DaTa_InserT = nil
  end

  def from(table_name)
    @NaMe_of_TablE = table_name
    self
  end

  def select(column_names)
    @query_Request_Mode_ = :select
    @Which_CoLumn += Array(column_names).map(&:to_s)
    self
  end

  def where(column, value)
    @where_FilTer << [column, value]
    self
  end

  def join(column_a, file_b, column_b)
    raise "Join can only be used with select query" unless @query_Request_Mode_ == :select

    @Join_InfoRmation = { NaMe_of_TablE: file_b, col_a: column_a, col_b: column_b }
    self
  end

  def order(direction, column)
    raise "Order can only be used with select query" unless @query_Request_Mode_ == :select

    @Which_OrdeR = { direction: direction, column: column }
    self
  end

  def insert(table_name)
    @query_Request_Mode_ = :insert
    @NaMe_of_TablE = table_name
    self
  end

  def values(data)
    raise "Values can only be used with insert or update query" unless [:insert, :update].include?(@query_Request_Mode_)

    @DaTa_InserT = data
    self
  end

  def set(data)
    values(data)
  end

  def update(table_name)
    @query_Request_Mode_ = :update
    @NaMe_of_TablE = table_name
    self
  end

  def delete
    @query_Request_Mode_ = :delete
    self
  end

  def run
    querY_ValiDation
    case @query_Request_Mode_
    when :select then execuTe_SelecT_Data
    when :insert then execuTe_InserT_Data
    when :update then execuTe_UpdaTe_Data
    when :delete then execuTe_DeleTe_Data
    else raise "Unknown query type"
    end
    rescue StandardError => e
        e.message
  
  end

  private

  def execuTe_InserT_Data
    my_data = CSV.read(@NaMe_of_TablE, headers: true)
    my_data << @DaTa_InserT
    update_csv_File(my_data)
    puts "Data inserted successfully."
  end



  def execuTe_UpdaTe_Data
    my_data = CSV.read(@NaMe_of_TablE, headers: true)
    rows_updated = 0
    my_data.each do |my_row|
      if satisfY_ConDitionS?(my_row)
        @DaTa_InserT.each { |col, val| my_row[col] = val }
        rows_updated += 1
    end
    end
  update_csv_File(my_data)
  if rows_updated.zero?
    puts "No data matching the update criteria found."
  else
    puts "Data updated successfully."
  end
  end



  def execuTe_SelecT_Data
    result = []
    my_data = CSV.read(@NaMe_of_TablE, headers: true)
    join_DaTa = @Join_InfoRmation ? CSV.read(@Join_InfoRmation[:NaMe_of_TablE], headers: true) : nil

    my_data.each do |my_row|
      if satisfY_ConDitionS?(my_row)
        if join_DaTa && my_row[@Join_InfoRmation[:col_a]]
          match = join_DaTa.find { |j_row| j_row[@Join_InfoRmation[:col_b]] == my_row[@Join_InfoRmation[:col_a]] }
          my_row = my_row.to_h.merge(match.to_h) if match
        end
        result << (selecT_All_Data? ? my_row.to_h : my_row.to_h.slice(*@Which_CoLumn))
      end
    end

    if @Which_OrdeR
      result.sort_by! { |my_row| my_row[@Which_OrdeR[:column]] }
      result.reverse! if @Which_OrdeR[:direction] == :desc
    end

    display_Output(result)
  end


  def selecT_All_Data?
    @Which_CoLumn.include?('*')
  end
  

def execuTe_DeleTe_Data
    my_data = CSV.read(@NaMe_of_TablE, headers: true)
    rows_before_deletion = my_data.size
    my_data.delete_if { |my_row| satisfY_ConDitionS?(my_row) }
    rows_after_deletion = my_data.size
    update_csv_File(my_data)
    if rows_after_deletion < rows_before_deletion
     puts "Data deleted successfully."
    else
     puts  "No data matching the deletion criteria found."
    end
  end
  
  

  def satisfY_ConDitionS?(my_row)
    @where_FilTer.all? { |col, val| my_row[col] == val }
  end


  def display_Output(result)
    result.each { |my_row| puts my_row.values.join('|') }
  end

  def querY_ValiDation
    raise "No query type specified" if @query_Request_Mode_ == :none
    raise "Table name is required" unless @NaMe_of_TablE
    raise "Table #{@NaMe_of_TablE} not found" unless File.exist?(@NaMe_of_TablE)
    
    if @query_Request_Mode_ == :select
      if @Which_OrdeR && !@Which_CoLumn.include?('*') && !@Which_CoLumn.include?(@Which_OrdeR[:column])
        raise "Order column must be selected"
      end
      if @Join_InfoRmation && !File.exist?(@Join_InfoRmation[:NaMe_of_TablE])
        raise "Join table #{@Join_InfoRmation[:NaMe_of_TablE]} not found"
      end
    end

    if [:insert, :update].include?(@query_Request_Mode_)
      raise "No data provided for #{@query_Request_Mode_}" unless @DaTa_InserT
    end
  end

  def update_csv_File(data)
    CSV.open(@NaMe_of_TablE, 'w', write_headers: true, headers: data.headers) do |csv|
      data.each { |my_row| csv << my_row }
    end
  end
end

def main
    #Write your test cases here e.g: 
# request = MySqliteRequest.new
# request = request.from('nba_player_data.csv')
# request = request.select('name')
# request.run


end

main

