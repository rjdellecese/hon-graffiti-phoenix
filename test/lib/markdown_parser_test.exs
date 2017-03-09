defmodule HonGraffitiPhoenix.MarkdownParserTest do
  use HonGraffitiPhoenix.ConnCase
  alias HonGraffitiPhoenix.Parsers.MarkdownParser


  @quote "^rBold ^gWow ^*Nein"
  @no_markdown "thisIsSoFakn' BORING"
  @broken_markdown "this^Qmakes no ^09s sense!!"


  test "parse returns a list" do
    parsed_markdown = MarkdownParser.parse(@no_markdown)
    assert is_list(parsed_markdown)
  end

  test "parsing an empty quote returns an empty list" do
    assert length(MarkdownParser.parse()) == 0
  end

  test "parsing returns an element for each style markdown" do
    assert length(MarkdownParser.parse(@quote)) == 3
  end

  test "broken markdown won't be parsed into a color" do
    markdown_data = MarkdownParser.parse(@broken_markdown)
    IO.inspect markdown_data
    color_array = Enum.reduce(markdown_data, [], fn(color_struct, acc) -> [Map.fetch!(color_struct, :color) | acc] end)
    assert Enum.all?(color_array, fn(x) -> x == "" end)
  end

end
