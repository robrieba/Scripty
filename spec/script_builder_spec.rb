require_relative '../lib/script_builder.rb'

RSpec.describe ScriptBuilder do
  sb = ScriptBuilder.new("test_data")

  context "attributes" do
    it "should respond to path" do
      expect(sb).to respond_to(:path)
    end

    it "should respond to script_lines" do
      expect(sb).to respond_to(:script_lines)
    end
  end

  context "#count_asc_files" do
    it "should count .asc files" do
      expect(sb.count_asc_files).to eq(1)
    end
  end

  context "#lines_numbered" do
    it "should count numbered lines" do
      expect(sb.lines_numbered).to eq(3)
    end
  end

  context "#lines_unnumbered" do
    it "should count unnumbered lines" do
      expect(sb.lines_unnumbered).to eq(5)
    end
  end

  context "#run" do
    sb.run

    it "should read script lines" do
      expect(sb.script_lines.count).to eq(8)
    end

    it "should read character names correctly" do
      expect(sb.script_lines[0].character).to eq("Captain")
      expect(sb.script_lines[1].character).to eq("Robot")
      expect(sb.script_lines[2].character).to eq("Robot")
      expect(sb.script_lines[3].character).to eq("Captain")
    end

    it "should read line numbers correctly" do
      expect(sb.script_lines[0].line_number).to eq(nil)
      expect(sb.script_lines[1].line_number).to eq(nil)
      expect(sb.script_lines[2].line_number).to eq("100")
      expect(sb.script_lines[3].line_number).to eq("1000")
    end

    it "should read line text correctly" do
      expect(sb.script_lines[0].line_text).to eq("Hello!")
      expect(sb.script_lines[1].line_text).to eq("Hello!")
      expect(sb.script_lines[2].line_text).to eq("&100 Good day to you, my friend.")
      expect(sb.script_lines[3].line_text).to eq("&1000 Quite a good day, indeed.")
    end

  end

end
