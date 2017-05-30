defmodule HonGraffitiPhoenix.HonQuoteView do
  use HonGraffitiPhoenix.Web, :view

  alias HonGraffitiPhoenix.HonQuote

  @lint {Credo.Check.Readability.Specs, false}
  def render("index.json", %{hon_quotes: hon_quotes}) do
    %{hon_quotes: Enum.map(hon_quotes, &hon_quote_json/1)}
  end

  @lint {Credo.Check.Readability.Specs, false}
  def render("show.json", %{hon_quote: hon_quote}) do
    %{hon_quote: hon_quote_json(hon_quote)}
  end

  @spec hon_quote_json(%HonQuote{}) ::
    %{id: integer, raw: String.t, inserted_at: String.t, updated_at: String.t}
  def hon_quote_json(hon_quote) do
    %{
      id: hon_quote.id,
      raw: hon_quote.raw,
      inserted_at: hon_quote.inserted_at,
      updated_at: hon_quote.updated_at
    }
  end
end
