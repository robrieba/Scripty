require_relative "../models/script_line.rb"

class ScriptBuilder
  attr_accessor :path, :script_lines

  def initialize(path)
    @path = path
    @script_lines = []
  end

  def count_asc_files
    Dir.glob("#{@path}/*.asc").count
  end

  def run
    Dir.glob("#{@path}/*.{asc,agf}").each do |f|
      puts "Reading: #{f}"
      sourcefile_line_number = 0
      IO.readlines(f).each do |s|
        sourcefile_line_number += 1
        if s =~ /\.Say/
          puts "#{sourcefile_line_number}: #{s}"
          @script_lines << ScriptLine.new(read_scriptline_character(s),
                                          read_scriptline_number(s),
                                          read_scriptline_text(s))
        end
        # if the file is the .agf, also search for dialog entries
        if f =~ /\.agf/ && s =~ /^[A-Za-z0-9]*:/
          @script_lines << ScriptLine.new(read_scriptline_dialog_character(s),
                                          read_scriptline_dialog_number(s),
                                          read_scriptline_dialog_text(s))
        end
      end
    end
  end

  def lines_numbered
    script_lines.count { |sl| sl.line_number && sl.line_number.to_i > 0  }
  end

  def lines_unnumbered
    script_lines.count { |sl| sl.line_number == nil || sl.line_number.to_i == 0  }
  end

  private

  def read_scriptline_text(s)
    # Find the text that is between the delimeters (" and ")
    t = s[/\(\"(.*?)\"\)/, 1]
    t.strip if t
  end

  def read_scriptline_character(s)
    # Return the word before the .Say method call (minus the first letter)
    s[/\w*\.Say/].split('.')[0][1..-1]
  end

  def read_scriptline_number(s)
    # Return the text (it's a number) behind the '&'
    s[/\&.* /].split[0][1..-1] if s[/\&.* /]
  end

  def read_scriptline_dialog_text(s)
    # Return everything after the fist semicolon
    s.split(':')[1..-1].join.strip
  end

  def read_scriptline_dialog_character(s)
    # Return everthing before the frist semicolon
    s.split(':')[0]
  end

  def read_scriptline_dialog_number(s)
    # Return the text (it's a number) following the first '&'
    s[/\&.* /].split[0][1..-1] if s[/\&.* /]
  end

end
