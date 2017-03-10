defmodule HonGraffitiPhoenix.Parsers.MarkupParser do
  alias HonGraffitiPhoenix.Parsers.DecoratedString

  @color_map %{
    "w" => "white", "*" => "white", "r" => "red",
    "b" => "blue", "y" => "yellow", "m" => "magenta",
    "n" => "brown", "p" => "purple", "o" => "orange",
    "t" => "teal", "v" => "grey", "g" => "green",
    "k" => "black"}

  @moduledoc """
  Parses strings using standard HoN style markup.
  """
  @type meta_string :: %DecoratedString{color: String.t, body: String.t}

  # This captures(named style) on a caret followed by EITHER
  # one of the characters, or 3 digits
  @capture_style_separately ~r/\^(?<color>\d{3}|[wrbymnpkotvg*])(?<body>.*)/i
  @caret_regex ~r/\^.*?(?=\^)/

#  Public functions
  @spec parse :: []
  def parse, do: []

  @doc """
  Separates a String into a list of Decorated string structs
  Splits on '^' the HoN markup indicator
  If no markup is found, a default is given.
  """
  @spec parse(String.t) :: [DecoratedString]
  def parse(quote) when quote == nil, do: []
  def parse(quote) do
    quote
    |> String.split(@caret_regex, trim: true, include_captures: true)
    |> Enum.map(&parse_segment/1)
  end

  @spec parse_segment(String.t) :: meta_string
  defp parse_segment(string) do
    map = Regex.named_captures(@capture_style_separately, string)
    if map != nil do
     %DecoratedString{body: map["body"], color: parse_markup_code(map["color"])}
   else
     %DecoratedString{body: string}
   end
  end

# Interpretting the markup codes
  @spec parse_markup_code(String.t) :: String.t
  defp parse_markup_code(markup_code) do
    case String.length(markup_code) do
      x when x == 1 -> Map.get(@color_map, markup_code)
      x when x > 1  -> "rgb(#{get_color_by_rgb(markup_code)})"
      _             -> markup_code
    end
  end

  defp get_color_by_rgb(rgb_string) do
    rgb_string
    |> String.graphemes
    |> Enum.map(&String.to_integer(&1) * 28)
    |> Enum.join(",")
  end

end
