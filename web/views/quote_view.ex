defmodule HonGraffitiPhoenix.QuoteView do
  use HonGraffitiPhoenix.Web, :view

  def render("index.json", %{quotes: quotes}) do
    %{quotes: Enum.map(quotes, &quote_json/1)}
  end

  def render("show.json", %{quote: quote}) do
    %{quote: quote_json(quote)}
  end

  def quote_json(quote) do
    %{
      raw: quote.raw,
      inserted_at: quote.inserted_at,
      updated_at: quote.updated_at
    }
  end
end
