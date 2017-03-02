defmodule HonGraffitiPhoenix.QuoteControllerTest do
  use HonGraffitiPhoenix.ConnCase

  alias HonGraffitiPhoenix.Quote

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

  test "#create renders and persists a valid quote" do
    conn = build_conn()

    conn = post conn, quote_path(conn, :create), quote: params_for(:quote)

    quote = Repo.get_by(Quote, raw: params_for(:quote).raw)
    assert json_response(conn, 201) == render_json("show.json", quote: quote)
  end

  test "#create renders errors and does not persist an invalid quote" do
    conn = build_conn()
    invalid_quote_changeset =
      Quote.changeset(%Quote{}, params_for(:invalid_quote))

    conn = post(
      conn,
      quote_path(conn, :create),
      quote: params_for(:invalid_quote)
    )

    assert json_response(conn, 422) ==
      render_changeset_json("error.json", changeset: invalid_quote_changeset)
    refute Repo.get_by(Quote, raw: params_for(:quote).raw)
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    HonGraffitiPhoenix.QuoteView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end

  defp render_changeset_json(template, assigns) do
    assigns = Map.new(assigns)

    HonGraffitiPhoenix.ChangesetView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end
end
