# require "amion_adapter/version"
require 'csv'
require 'net/http'

class AmionAdapter
  
  def initialize(login) # login is the account name
    @login = login.strip.gsub(' ', '+')
    @report_raw_csv = nil
    @report_code = nil
  end
  
  # report_code contents        header_rows   columns   headers
  # 625c        all shifts
  # 619         call schedule
  # 2           person_ids
  # 34          role_ids        0-3           2
  def fetch_report(report_code, date_par)
    def academic_year(date_par) # converts the month/year into the academic year
      if date_par.month >= 6
        date_par.year
      else
        date_par.year-1
      end
    end
    
    uri = URI.parse("http://www.amion.com/cgi-bin/ocs?Lo=#{@login}&Rpt=#{report_code}" +
      "&Month=#{date_par.month}&year=#{academic_year( date_par )}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    @report_code = report_code
    @report_raw_csv = http.request(request).body
  end
  
  
  # =======================   Parsing functionality   =========================
  def parse 
    raise "This has not been implemented yet. Due to the variability of report format, will need to implement a series of specialized parsers"
  end
  
  # def parse_625c
  #   
  #   csv = CSV.parse( @report_raw_csv ).select {|line| line.length > 10}
  # 
  #   # typical row ["Jones, Lawrence", "34", "2", "Echo", "3", "3", "7-1-14", "0700", "0700", "Fellow 1", "267-324-7551", "", "lawrence.jones@university.edu", "1", "", "r", "Echo"]
  #   # headers = ['name', 'amion_id', 'x', 'assignment_name', 'x', 'x', 'date', 'start_time', 'end_time',  'staff_type', 'pager', 'tel', 'email', 'messageable', 'x', 'assignment_type', 'grouping']
  #   csv.collect do |row| 
  #     {
  #       name: row[0],
  #       amion_id: row[1],
  #       assignment_name: row[3],
  #       shift_start: Time.new((r=row[6].split("-"))[2].to_i + 2000, r[0].to_i, r[1].to_i, military_hours(row[7]), military_minutes( row[7]),0,"-04:00").iso8601,
  #       shift_end: Time.new((r=row[6].split("-"))[2].to_i + 2000, r[0].to_i, r[1].to_i, military_hours(row[8]), military_minutes( row[8]),0,"-04:00").iso8601,
  #       staff_type: row[9],
  #       pager: row[10],
  #       tel: row[11],
  #       email: row[12],
  #       assignment_type: row[15],
  #       grouping: row[16]
  #     }
  #   end
  # end
  # 
  # def self.military_hours( military )
  #   (military.to_i / 100).floor
  # end
  # 
  # def self.military_minutes( military )
  #   military.to_i % 100
  # end
  # 
  # def self.parse_call_schedule(data)
  #   headers = ['person_name', 'person_id', 'person_backup_id', 'role_name', 'shift_id', 'shift_backup_id', 'shift_date', 'start_time', 'end_time']
  #   csv = CSV.parse(data).select{|e| e.size > 7}.compact
  #   table = csv.collect {|row| Hash[headers.zip(row)]}.compact
  #   table
  # end
end
