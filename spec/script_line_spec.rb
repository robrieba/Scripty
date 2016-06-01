require_relative '../models/script_line.rb'

RSpec.describe ScriptLine do

  context "attributes" do
    sl = ScriptLine.new('Bob', '10', 'This is his line.')

    it "should respond to character" do
      expect(sl).to respond_to(:character)
    end

    it "should respond to line_number" do
      expect(sl).to respond_to(:line_number)
    end

    it "should respond to line_text" do
      expect(sl).to respond_to(:line_text)
    end
  end

  context "#ogg_filename" do
    sl = ScriptLine.new('Bob', '10', 'This is his line.')
    it "should return an AGS .ogg filename" do
      expect(sl.ogg_filename).to eq("BOB10.ogg")
    end
  end

  context "#ags_character_name" do
    sl = ScriptLine.new('Bob', '10', 'This is his line.')
    it "should return an AGS character name" do
      expect(sl.ags_character_name).to eq("cBob")
    end
  end


end
