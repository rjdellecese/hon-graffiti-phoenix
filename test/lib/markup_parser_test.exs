defmodule HonGraffitiPhoenix.MarkupParserTest do
  use HonGraffitiPhoenix.ConnCase
  alias HonGraffitiPhoenix.Parsers.MarkupParser

  test "parsing an empty quote returns an empty list" do
    assert length(MarkupParser.parse()) == 0
  end

  test "it returns the original string if there is no style" do
    no_markup = "(nsfw)thisIsSoFakn' BORING"

    parsed = MarkupParser.parse(no_markup)

    assert length(parsed) == 1
    assert hd(parsed).body == no_markup
  end

  test "it returns the caret if the style code is invalid" do
    invalid_markup = "^j doesn't correspond to a code"

    parsed = MarkupParser.parse(invalid_markup)

    assert length(parsed) == 1
    assert hd(parsed).body == invalid_markup
  end

  test "it parses strings that don't start with carets" do
    caret_anywhere = "this is a ^rrandom string"

    parsed = MarkupParser.parse(caret_anywhere)

    assert length(parsed) == 2
    assert hd(parsed).body == "this is a "
  end

  test "it parses multiple seqments of valid markup" do
    valid_quote = "^rBold ^gWow ^*Nein"

    parsed = MarkupParser.parse(valid_quote)

    assert length(parsed) == 3
    assert hd(parsed).body == "Bold "
    assert hd(parsed).color == "red"
    assert List.last(parsed).body == "Nein"
    assert List.last(parsed).color == "white"
  end

  describe "color code interpretation" do
    test "it parses 3 digits into an rgb code" do
      rgb_words = "^123words"

      rgb_parsed = MarkupParser.parse(rgb_words)

      assert hd(rgb_parsed).color == "rgb(28,56,84)"
    end

    test "it parses characters into color names" do
      red_words = "^rwords"

      parsed = MarkupParser.parse(red_words)

      assert hd(parsed).color == "red"
    end

    test "it will default to white if there is no valid markup" do
      invalid_markup = "this^Qmakes no ^09s sense!!"

      parsed = MarkupParser.parse(invalid_markup)

      assert Enum.all?(parsed, fn(decorated_string) -> Map.fetch!(decorated_string, :color) == "white" end)
    end
  end

  describe "parse multiple sequential carets" do
    test "it groups multiple sequential carets into one body, except the last one" do
      valid_multiple_carets = "Don't freak^^^^^too many carets"

      parsed = MarkupParser.parse(valid_multiple_carets)

      assert hd(parsed).body == "Don't freak^^^^"
    end

    test "it handles invalid markup like a normal, leave it alone" do
      invalid_multiple_carets = "Don't freak^^^^^1too many carets"

      parsed = MarkupParser.parse(invalid_multiple_carets)

      assert List.last(parsed).color == "white"
      assert List.last(parsed).body == "^1too many carets"
    end

    test "it parses the last caret of a sequence" do
      valid_multiple_carets = "Don't freak^^^^^too many carets"

      parsed = MarkupParser.parse(valid_multiple_carets)

      assert List.last(parsed).body == "oo many carets"
      assert List.last(parsed).color == "teal"
    end
  end


end
