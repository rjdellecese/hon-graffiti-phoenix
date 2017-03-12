defmodule HonGraffitiPhoenix.MarkupParserTest do
  use HonGraffitiPhoenix.ConnCase
  alias HonGraffitiPhoenix.Parsers.MarkupParser


  @quote "^rBold ^gWow ^*Nein"
  @no_markdown "thisIsSoFakn' BORING"
  @broken_markdown "this^Qmakes no ^09s sense!!"
  @invalid_markup_code "^j doesn't correspond to a code"
  @caret_not_first "this is a ^rrandom string"
  @multiple_carets "We shouldn't freak over ^^^^^too many carets"


  test "it returns the original string if there is no style" do
    parsed = MarkupParser.parse(@no_markdown)
    assert length(parsed) == 1
    assert hd(parsed).body == @no_markdown
  end

  test "it returns the caret if the style code is invalid" do
    parsed = MarkupParser.parse(@invalid_markup_code)
    assert length(parsed) == 1
    assert hd(parsed).body == @invalid_markup_code
  end

  test "it parses strings that don't start with carets" do
    parsed = MarkupParser.parse(@caret_not_first)
    assert length(parsed) == 2
    assert hd(parsed).body == "this is a "
  end

  test "parsing an empty quote returns an empty list" do
    assert length(MarkupParser.parse()) == 0
  end

  test "it returns an element for each valid style code" do
    assert length(MarkupParser.parse(@quote)) == 3
  end

  test "it will default to white if there is no valid markup" do
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

  test "it can handle multiple carets" do
    parsed = MarkupParser.parse(@multiple_carets)
    assert length(parsed) == 2
    assert hd(parsed).body == "We shouldn't freak over ^^^^"
    assert hd(parsed).color == "white"
    assert List.last(parsed).color == "teal"
  end

end
