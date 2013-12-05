require 'roo'
def endtime(date,starttime,endtime)
    if endtime > starttime
        end_time = DateTime.new(date.year,date.month,date.day,endtime.hour,endtime.min,endtime.sec)
    else
        end_time = DateTime.new(date.year,date.month,date.day + 1,endtime.hour,endtime.min,endtime.sec)
    end
end_time



end

def convert_xml(file)
    if file.respond_to?(:read)
        xml_contents = file.read
    elsif file.respond_to?(:path)
        xml_contents = File.read(file.path)
    else
        logger.error "Bad file_data: #{file.class.name}: #{file.inspect}"
    end
    errors = Array.new
    xml = Nokogiri::XML(xml_contents)
    xml.css('time_report').each do |node|
            children = node.children
            e_id = children.css('employee_ID').inner_text
            if children.css('client_ID').inner_text.blank? && !children.css('client_name').inner_text.blank?
                c_id = Client.where(name: children.css('client_name').inner_text)
            else
                c_id = children.css('client_ID').inner_text
            end
            p_id = children.css('project_ID').inner_text
            start = children.css('time_record').children.css('project_start_time').inner_text.to_time
            e_time = children.css('time_record').children.css('project_end_time').inner_text.to_time
            date = children.css('date_created').inner_text.to_date
            start_time = DateTime.new(date.year,date.month, date.day, start.hour, start.min, start.sec)
            end_time = endtime(date,start,e_time)

            project = Project.new(
                id: p_id,
                name: "Project #{p_id}"
            )
            client = Client.new(
                id: c_id,
                name: children.css('client_name').inner_text
            )
            employee = Employee.new( 
                id: e_id,
                name: children.css('employee_name').inner_text,
                email: children.css('employee_name').inner_text.gsub(/\s+/,"").concat("@ist420.com"),
                password: "1234567", password_confirmation: "1234567"
            )
            timestamp = Timestamp.new(
                start_time: start_time,
                end_time: end_time,
                employee_id: e_id,
                client_id: c_id,
                project_id: p_id
                                         )
            if project.save
            else
                errors << project.errors.full_messages.to_sentence
            end
            if client.save
            else
                errors << client.errors.full_messages.to_sentence
            end

            if employee.save
            else
                errors <<  employee.errors.full_messages.to_sentence
            end
            if timestamp.save

            else
                errors << timestamp.errors.full_messages.to_sentence
            end


        end
    if !errors.nil?
        #flash.now[:error] = errors
    end

    end
def convert_xls(file)
    tmp = file.tempfile
    filename = File.join("public", file.original_filename)
    FileUtils.cp tmp.path, filename

    xl = Roo::Excel.new(filename)
    xl.default_sheet = xl.sheets.first
    date_created_column = tcell(xl, 'Date Created')
    project_id_column = tcell(xl, 'Project ID')
    employee_id_column = tcell(xl, 'Employee ID')
    employee_name_column = tcell(xl, 'Employee Name')
    start_time_column = tcell(xl, 'Start Time')
    end_time_column = tcell(xl, 'End Time')
    client_name_column = tcell(xl, 'Organization')
    client_id = tcell(xl, 'Client ID')
    project_id = tcell(xl, 'Project ID')
    2.upto(xl.last_row) do |line|
        
        project = Project.new(
            id: xl.cell(line,project_id),
            name: "Project #{xl.cell(line,project_id)}"
        )
        if project.save
        end
       client = Client.new(
          name: xl.cell(line,client_name_column),
          id: xl.cell(line,client_id))
       if client.save
       end
       employee = Employee.new(
           name: xl.cell(line,employee_name_column),
           id: xl.cell(line,employee_id_column),
           email: xl.cell(line,employee_name_column).gsub(/\s+/,"").concat("@ist420.com"),
           password: "123456",
           password_confirmation: "123456"
       )
       if employee.save
       end
       timestamp = Timestamp.new(
           employee_id: xl.cell(line,employee_id_column),
           client_id: xl.cell(line,client_id_column),
           project_id: xl.cell(line,project_id),
           start_time: xl.cell(line,start_time_column),
           end_time: xl.cell(line,end_time_column)
       )
       if timestamp.save
       end
end
end
def tcell(roo, column_title)

    roo.first_column.upto(roo.last_column).map{ |column| roo.cell(1, column) }.index( cell_type ) + 1
end

            
