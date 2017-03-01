defmodule HonGraffitiPhoenix.QuoteControllerTest do
  use HonGraffitiPhoenix.ConnCase

  test "#index renders a list of quotes" do
    conn = build_conn()
    quote = insert(:quote)

    conn = get conn, quote_path(conn, :index)

    assert json_response(conn, 200) ==
      render_json("index.json", quotes: [quote])
  end

  test "#show renders a single quote" do
    conn = build_conn()
    quote = insert(:quote)

    conn = get conn, quote_path(conn, :show, quote)

    assert json_response(conn, 200) == render_json("show.json", quote: quote)
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    HonGraffitiPhoenix.QuoteView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end
end
