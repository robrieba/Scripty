require 'csv'
require_relative "../models/script_line.rb"

class ScriptBuilder
  attr_accessor :path, :script_lines

  def initialize(path, quiet=false, character=nil)
    @path = path
    @script_lines = []
    @quiet = quiet
    @character = character
  end

  def count_asc_files
    Dir.glob("#{@path}/*.asc").count
  end

  def run
    Dir.glob("#{@path}/*.{asc,agf}").each do |f|
      puts "Reading: #{f}" unless @quiet
      sourcefile_line_number = 0
      IO.readlines(f).each do |s|
        sourcefile_line_number += 1
        is_agf_file = f =~ /\.agf/
        if (s =~ /\.Say.*/) || (is_agf_file && s =~ /^[A-Za-z0-9]*:/)
          puts "#{sourcefile_line_number}: #{s}" unless @quiet
          character, number, text = read_scriptline(s, is_agf_file)
          @script_lines << ScriptLine.new(character, number, text) if @character == character
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

  def read_scriptline(s, is_agf_file)
    if is_agf_file
      return read_scriptline_dialog_character(s), read_scriptline_dialog_number(s), read_scriptline_dialog_text(s)
    else
      return read_scriptline_character(s), read_scriptline_number(s), read_scriptline_text(s)
    end
  end

  def read_scriptline_text(s)
    # Find the text that in the '#Say' method(s)
    s.split(/\"(.*?)\"/)[1]
  end

  def read_scriptline_character(s)
    # Return the word before the '#Say' method call (minus the first letter)
    s[/\w*\.Say.*/].split('.')[0]
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
    "c#{s.split(':')[0]}"
  end

  def read_scriptline_dialog_number(s)
    # Return the text (it's a number) following the first '&'
    s[/\&.* /].split[0][1..-1] if s[/\&.* /]
  end

end
