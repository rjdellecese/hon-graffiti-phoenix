defmodule HonGraffitiPhoenix.QuoteView do
  use HonGraffitiPhoenix.Web, :view

  alias HonGraffitiPhoenix.Quote

  @lint {Credo.Check.Readability.Specs, false}
  def render("index.json", %{quotes: quotes}) do
    %{quotes: Enum.map(quotes, &quote_json/1)}
  end

  @lint {Credo.Check.Readability.Specs, false}
  def render("show.json", %{quote: quote}) do
    %{quote: quote_json(quote)}
  end

  @spec quote_json(%Quote{}) ::
    %{raw: String.t, inserted_at: String.t, updated_at: String.t}
  def quote_json(quote) do
    %{
      raw: quote.raw,
      inserted_at: quote.inserted_at,
      updated_at: quote.updated_at
    }
  end
end
