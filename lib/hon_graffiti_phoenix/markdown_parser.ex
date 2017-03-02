defmodule HonGraffitiPhoenix.MarkdownParser do
  use HonGraffitiPhoenix.Web, :view

  # This captures(named style) on a caret followed by EITHER
  # one of the characters, or 3 digits
  @hon_markup_capture ~r/\^((?<style>(\d{3})|[wrbymnpkotvg*]))/i
  @hon_markup_splitter ~r/\^.*?(?=\^)/

#  Public functions
  def parse(), do: []
  def parse(quote) when quote == nil, do: []
  def parse(quote) do
    separate_styles = split_on_markdown(quote)
    style_structs = Enum.reduce(separate_styles, [], fn(string, acc) -> [create_style_struct(string) | acc] end)
    style_structs
  end

# Private functions

  # Splits at every caret, and includes the caret.
  # returns a list of strings with a single markdown style in them
  def create_style_struct(string) do
    color = get_markdown(string) |> parse_markdown
    body = get_without_markdown(string) |> String.trim
    %{color: color, body: body}
  end

  def split_on_markdown(string) do
    Regex.split(@hon_markup_splitter , string, trim: true, include_captures: true)
  end

  def get_markdown(string) do
    style_map = Regex.named_captures(@hon_markup_capture, string)
    if (style_map != nil), do: style_map["style"], else: ""
  end

  def get_without_markdown(string) do
    Regex.replace(@hon_markup_capture, string, "")
  end

# Interpretting the markdown codes
  def parse_markdown(markdown_code) do
    case String.length(markdown_code) do
      x when x == 1 -> get_color_by_code(markdown_code)
      x when x > 1  -> get_color_by_rgb(markdown_code)
      _             -> markdown_code
    end
  end

  def get_color_by_rgb(rgb_string) do
    "rgb(#{rgb_string})"
  end

  def get_color_by_code(color_code) do
    case String.downcase(color_code) do
      "w" -> "white"
      "*" -> "white"
      "r" -> "red"
      "b" -> "blue"
      "y" -> "yellow"
      "m" -> "magenta"
      "n" -> "brown"
      "p" -> "purple"
      "k" -> "black"
      "o" -> "orange"
      "t" -> "teal"
      "v" -> "grey"
      "g" -> "green"
      ""  -> "black"
    end
  end

end
