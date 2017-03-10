defmodule HonGraffitiPhoenix.MarkupParserTest do
  use HonGraffitiPhoenix.ConnCase
  alias HonGraffitiPhoenix.Parsers.MarkupParser


  @quote "^rBold ^gWow ^*Nein"
  @no_markdown "thisIsSoFakn' BORING"
  @broken_markdown "this^Qmakes no ^09s sense!!"
  @invalid_markup_code "^j doesn't coorespond to a code"


  test "it returns the caret if the style code is invalid" do
    parsed = MarkupParser.parse(@invalid_markup_code)
    assert length(parsed) == 1
    assert hd(parsed).body == @invalid_markup_code
  end

  test "it returns the original string if there is no style" do
    parsed = MarkupParser.parse(@no_markdown)
    assert length(parsed) == 1
    assert hd(parsed).body == @no_markdown
  end

  test "parsing an empty quote returns an empty list" do
    assert length(MarkupParser.parse()) == 0
  end

  test "it returns an element for each valid style code" do
    assert length(MarkupParser.parse(@quote)) == 3
  end

  test "invalid markup won't be parsed into a color, default is white" do
    markdown_data = MarkupParser.parse(@broken_markdown)
    color_array = Enum.reduce(markdown_data, [], fn(color_struct, acc) -> [Map.fetch!(color_struct, :color) | acc] end)
    assert Enum.all?(color_array, fn(x) -> x == "white" end)
  end

  test "it can parse 3 digit codes or single characters" do
    assert hd(MarkupParser.parse("^000")).color == "rgb(0,0,0)"
    assert hd(MarkupParser.parse("^123")).color == "rgb(28,56,84)"
    assert hd(MarkupParser.parse("^r")).color == "red"
    assert hd(MarkupParser.parse("^*")).color == "white"
  end

end
