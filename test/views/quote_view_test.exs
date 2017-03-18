defmodule HonGraffitiPhoenix.QuoteViewTest do
  use HonGraffitiPhoenix.ConnCase, async: true

  alias HonGraffitiPhoenix.QuoteView

  test "quote_json" do
    quote = insert(:quote)

    rendered_quote = QuoteView.quote_json(quote)

    assert rendered_quote == %{
      id: quote.id,
      raw: quote.raw,
      inserted_at: quote.inserted_at,
      updated_at: quote.updated_at
    }
  end

  test "index.json" do
    quote = insert(:quote)

    rendered_quotes = QuoteView.render("index.json", %{quotes: [quote]})

    assert rendered_quotes == %{
      quotes: [QuoteView.quote_json(quote)]
    }
  end

  test "show.json" do
    quote = insert(:quote)

    rendered_quote = QuoteView.render("show.json", %{quote: quote})

    assert rendered_quote == %{quote: QuoteView.quote_json(quote)}
  end
end
