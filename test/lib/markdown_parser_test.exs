defmodule HonGraffitiPhoenix.MarkupParserTest do
  use HonGraffitiPhoenix.ConnCase
  alias HonGraffitiPhoenix.Parsers.MarkupParser


  @quote "^rBold ^gWow ^*Nein"
  @no_markdown "thisIsSoFakn' BORING"
  @broken_markdown "this^Qmakes no ^09s sense!!"


  test "parse returns a list" do
    parsed_markdown = MarkupParser.parse(@no_markdown)
    assert is_list(parsed_markdown)
  end

  test "parsing an empty quote returns an empty list" do
    assert length(MarkupParser.parse()) == 0
  end

  test "parsing returns an element for each style markdown" do
    assert length(MarkupParser.parse(@quote)) == 3
  end

  test "broken markdown won't be parsed into a color" do
    markdown_data = MarkupParser.parse(@broken_markdown)
    color_array = Enum.reduce(markdown_data, [], fn(color_struct, acc) -> [Map.fetch!(color_struct, :color) | acc] end)
    assert Enum.all?(color_array, fn(x) -> x == "" end)
  end

  test "it can parse 3 digit codes or single characters" do
    assert MarkupParser.parse_markdown_code("000") == "rgb(0,0,0)"
    assert MarkupParser.parse_markdown_code("123") == "rgb(28,56,84)"
    assert MarkupParser.parse_markdown_code("r") == "red"
    assert MarkupParser.parse_markdown_code("*") == "white"
  end

end
