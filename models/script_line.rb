class ScriptLine
  attr_accessor :character, :line_number, :line_text

  def initialize(character, line_number, line_text)
    @character, @line_number, @line_text = character, line_number, line_text
  end
  
  def ogg_filename
    # AGS voice files are the first 4 characters of the name, plus the line number
    "#{character[0..3].upcase}#{line_number}.ogg"
  end

  def ags_character_name
    # create an AGS script character by prepending a "c" onto the name
    "c#{@character}"
  end

end
