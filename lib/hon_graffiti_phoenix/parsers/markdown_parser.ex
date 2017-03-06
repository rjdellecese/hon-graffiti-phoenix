defmodule HonGraffitiPhoenix.Parsers.MarkdownParser do
  alias HonGraffitiPhoenix.Parsers.DecoratedString

  @moduledoc """
  Parses strings using standard HoN style markup.
  """

  @type meta_string :: %DecoratedString{color: String.t, body: String.t}

  # This captures(named style) on a caret followed by EITHER
  # one of the characters, or 3 digits
  @hon_markup_capture ~r/\^((?<style>(\d{3})|[wrbymnpkotvg*]))/i
  @hon_markup_splitter ~r/\^.*?(?=\^)/

#  Public functions
  @spec parse :: []
  def parse, do: []

  @spec parse(String.t) :: [DecoratedString]
  def parse(quote) when quote == nil, do: []
  def parse(quote) do
    separate_styles = split_on_markdown(quote)
    Enum.reduce(separate_styles, [],
      fn(string, acc) -> [parse_segment(string) | acc] end)
  end

# Private functions
# Splits at every caret, and includes the caret.
# returns a list of strings with a single markdown style in them

  @doc """
  Separates a String into it's markup and body.
  If no markup is found, a default is given.
  """
  @spec parse_segment(String.t) :: meta_string
  def parse_segment(string) do
    color = string |> get_markdown |> parse_markdown_code
    body = string |> get_without_markdown |> String.trim
    %DecoratedString{color: color, body: body}
  end

  @spec split_on_markdown(String.t) :: [String.t]
  def split_on_markdown(string) do
    Regex.split(@hon_markup_splitter,
      string,
      trim: true,
      include_captures: true)
  end

  defp get_markdown(string) do
    style_map = Regex.named_captures(@hon_markup_capture, string)
    if style_map != nil, do: style_map["style"], else: ""
  end

  defp get_without_markdown(string) do
    Regex.replace(@hon_markup_capture, string, "")
  end

# Interpretting the markdown codes
  defp parse_markdown_code(markdown_code) do
    case String.length(markdown_code) do
      x when x == 1 -> get_color_by_code(markdown_code)
      x when x > 1  -> get_color_by_rgb(markdown_code)
      _             -> markdown_code
    end
  end

  defp get_color_by_rgb(rgb_string) do
    "rgb(#{rgb_string})"
  end

  @lint false
  defp get_color_by_code(color_code) do
    case String.downcase(color_code) do
      "w" -> "white"
      "*" -> "white"
      "r" -> "red"
      "b" -> "blue"
      "y" -> "yellow"
      "m" -> "magenta"
      "n" -> "brown"
      "p" -> "purple"
      "o" -> "orange"
      "t" -> "teal"
      "v" -> "grey"
      "g" -> "green"
      "k" -> "black"
      ""  -> "black"
    end
  end

end
