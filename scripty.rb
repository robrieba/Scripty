require 'rubygems'
require 'thor'
require_relative 'lib/script_builder'

class Scripty < Thor
  desc "dump <source_path>", "Print a complete dump of line of speech in the source code at <source_path>."
  long_desc <<-INSTRUCTIONS
  Scripty is a command line tool for mananging AGS speech.

  Command:
    dump  Print a complete lising of every line of speech in the source code.

            $ ruby scripty dump ../my_ags_game

          Output:
            <character name>, <line number>, <speech text>

          Ex:
            CharacterName, 2, &2 Hello!

  INSTRUCTIONS

  def dump(source_path)
    sb = ScriptBuilder.new(source_path)
    sb.run

    sb.script_lines.each do |sl|
      puts "#{sl.character}, #{sl.line_number}, #{sl.line_text}"
    end
  end
end

Scripty.start(ARGV)
