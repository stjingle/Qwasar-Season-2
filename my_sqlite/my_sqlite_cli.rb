require "readline"
require_relative 'my_sqlite_request'
require 'csv'

class MySqliteQueryCli
    def analyze_select_command(user_Inputs)
        my_Requests = MySqliteRequest.new
        do_SeLect_CoLumns = user_Inputs.match(/SELECT\s+(.+)\s+FROM/)[1].split(/[\s,]+/).map(&:strip)
        name_of_TabLe = user_Inputs.match(/FROM\s+(\S+)/)[1] + ".csv"
        my_Requests.from(name_of_TabLe)
    
        my_Requests.select(do_SeLect_CoLumns.length > 1 ? do_SeLect_CoLumns[0..1] : do_SeLect_CoLumns[0])
    
        if user_Inputs.include?("WHERE")
          where_FilTer =  analyze_where_clause(user_Inputs)
          my_Requests.where(where_FilTer[0], where_FilTer[1])
        end
    
        my_Requests.run
    end

    def  analyze_insert_command(user_Inputs)
        my_Requests = MySqliteRequest.new
        name_of_TabLe = user_Inputs.match(/INTO\s+(\S+)/)[1] + ".csv"
    
        geT_Values = user_Inputs.match(/VALUES\s(.+)/)[1].split(',').map(&:strip).map { |value| value.gsub(/[()]/, '') }
    
        get_Columns_from_File = CSV.read(name_of_TabLe, headers: true).headers
        do_Hash = Hash[get_Columns_from_File.zip(geT_Values)]
    
        my_Requests.insert(name_of_TabLe).values(do_Hash).run
    end

    def  analyze_update_command(user_Inputs)
        my_Requests = MySqliteRequest.new
        name_of_TabLe = user_Inputs.match(/UPDATE\s+(\S+)/)[1] + ".csv"
        where_FilTer =  analyze_where_clause(user_Inputs)
    
        do_Set_Values = user_Inputs.match(/SET\s+(.+)\s+WHERE/)[1].split(',').map(&:strip).map { |value| value.gsub(/['']/, '') }
        do_Hash = Hash[do_Set_Values.map { |item| item.split(' = ') }]
    
        my_Requests.update(name_of_TabLe).set(do_Hash).where(where_FilTer[0], where_FilTer[1]).run
    end

    def analyze_delete_command(user_Inputs)
        my_Requests = MySqliteRequest.new
        name_of_TabLe = user_Inputs.match(/FROM\s+(\S+)/)[1] + ".csv"
        where_FilTer =  analyze_where_clause(user_Inputs)
    
        my_Requests.delete.from(name_of_TabLe).where(where_FilTer[0], where_FilTer[1]).run
    end

    def analyze_command(inputs_Arguments)
        case inputs_Arguments
        when /SELECT/ then analyze_select_command(inputs_Arguments)
        when /INSERT/ then analyze_insert_command(inputs_Arguments)
        when /DELETE/ then analyze_delete_command(inputs_Arguments)
        when /UPDATE/ then  analyze_update_command(inputs_Arguments)
        else puts "Invalid input"
        end
    end

  def collect_Input_from_User
    my_Line = Readline.readline("my_sqlite_cli> ", true)
    my_Line.nil? ? (p Readline::HISTORY.to_a) : my_Line
  end

  def  analyze_where_clause(user_Inputs)
    where_FilTer = user_Inputs.split('WHERE')[1].scan(/\S+/)
    [where_FilTer[0], where_FilTer[2].delete('"\'')]
  end


  def run
    puts "MySQLite version 0.1 20XX-XX-XX"
    loop do
      my_CoMMands = collect_Input_from_User
      break if my_CoMMands == 'quit'

      analyze_command(my_CoMMands)
    end
  end
end

MySqliteQueryCli.new.run
