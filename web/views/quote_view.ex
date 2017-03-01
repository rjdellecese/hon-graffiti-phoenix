defmodule HonGraffitiPhoenix.QuoteView do
  use HonGraffitiPhoenix.Web, :view

  # This captures(named style) on a caret followed by EITHER one of the characters, or 3 digits
  @markdown_regex ~r/\^((?<style>(\d{3})|[wrbymnpkotvg*]))/i

  def parse(quote) do
    separate_styles = split_on_markdown(quote)
    style_structs = Enum.reduce(separate_styles, [], fn(string, acc) -> [create_style_struct(string) | acc] end)
    IO.inspect style_structs
    style_structs
  end

  def get_markdown(string) do
    style_map = Regex.named_captures(@markdown_regex, string)
    if (style_map != nil), do: style_map["style"], else: ""
  end

  def get_without_markdown(string) do
    Regex.replace(@markdown_regex, string, "")
  end

  def parse_markdown(string) do
    markdown = get_markdown(string)
    case String.length(markdown) do
      x when x == 1 -> get_color_by_code(markdown)
      x when x > 1  -> get_color_by_rgb(markdown)
      x             -> x
    end
  end

  # Splits at every caret, and includes the caret.
  # returns a list of strings with a single markdown style in them
  def split_on_markdown(string) do
    string_styles = Regex.split(~r/\^.*?(?=\^)/ , string, trim: true, include_captures: true)
  end

  def create_style_struct(string) do
    color = parse_markdown(string)
    body = get_without_markdown(string) |> String.trim
    IO.puts "style is #{color} and body is #{body}"
    %{color: color, body: body}
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
      _   -> "didn't match anything"
    end
  end

end
