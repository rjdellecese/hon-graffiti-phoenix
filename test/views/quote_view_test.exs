defmodule HonGraffitiPhoenix.HonQuoteViewTest do
  use HonGraffitiPhoenix.ConnCase, async: true

  alias HonGraffitiPhoenix.HonQuoteView

  test "hon_quote_json" do
    hon_quote = insert(:hon_quote)

    rendered_hon_quote = HonQuoteView.hon_quote_json(hon_quote)

    assert rendered_hon_quote == %{
      id: hon_quote.id,
      raw: hon_quote.raw,
      inserted_at: hon_quote.inserted_at,
      updated_at: hon_quote.updated_at
    }
  end

  test "index.json" do
    hon_quote = insert(:hon_quote)

    rendered_hon_quotes =
      HonQuoteView.render("index.json", %{hon_quotes: [hon_quote]})

    assert rendered_hon_quotes == %{
      hon_quotes: [HonQuoteView.hon_quote_json(hon_quote)]
    }
  end

  test "show.json" do
    hon_quote = insert(:hon_quote)

    rendered_hon_quote =
      HonQuoteView.render("show.json", %{hon_quote: hon_quote})

    assert rendered_hon_quote ==
      %{hon_quote: HonQuoteView.hon_quote_json(hon_quote)}
  end
end
