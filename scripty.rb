require 'rubygems'
require 'thor'
require_relative 'lib/script_builder'

class Scripty < Thor
  option :quiet, :type => :boolean, :default => false
  desc "dump <source_path>", "Print a complete dump of the speech lines in the source code at <source_path>."
  long_desc <<-INSTRUCTIONS
  Print a complete lising of every line of speech.

            $ ruby scripty dump ../my_ags_game

          Output:
            <character name>, <line number>, <speech text>

          Ex:
            CharacterName, 2, &2 Hello!

  INSTRUCTIONS
  def dump(source_path)
    build_script(source_path)
    @sb.script_lines.each do |sl|
      puts "#{sl.character}, #{sl.line_number}, #{sl.line_text}"
    end
  end

  option :quiet, :type => :boolean, :default => false
  option :character, :type => :string
  desc "script <source_path>", "Print a formated script of the speech lines in the source code at <source_path>."
  long_desc <<-INSTRUCTIONS
  Print a formatted script of the speech lines in the source code at <source_path>.
  The script will be sorted by the character's name.

            $ ruby scripty script ../my_ags_game

          Output:
            CharacterName: &100 This is a line of text!


  INSTRUCTIONS
  def script(source_path)
    build_script(source_path)
    @sb.script_lines.sort! { |x,y| x.character <=> y.character  }
    @sb.script_lines.each do |sl|
      puts "#{sl.character}: #{sl.line_text}"
    end
  end

  private

  def build_script(source_path)
    @sb = ScriptBuilder.new(source_path, options[:quiet], options[:character])
    @sb.run
  end

end

Scripty.start(ARGV)
