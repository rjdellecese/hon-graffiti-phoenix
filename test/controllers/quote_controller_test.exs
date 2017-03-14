defmodule HonGraffitiPhoenix.QuoteControllerTest do
  use HonGraffitiPhoenix.ConnCase

  alias HonGraffitiPhoenix.Quote

  setup do
    %{conn: build_conn()}
  end

  test "#index renders a list of quotes", %{conn: conn} do
    quote = insert(:quote)

    conn = get conn, quote_path(conn, :index)

    assert json_response(conn, 200) ==
      render_json("index.json", quotes: [quote])
  end

  test "#show renders a single quote", %{conn: conn} do
    quote = insert(:quote)

    conn = get conn, quote_path(conn, :show, quote)

    assert json_response(conn, 200) == render_json("show.json", quote: quote)
  end

  test "#create renders and persists a valid quote", %{conn: conn} do
    conn = post conn, quote_path(conn, :create), quote: params_for(:quote)

    quote = Repo.get_by(Quote, raw: params_for(:quote).raw)
    assert json_response(conn, 201) == render_json("show.json", quote: quote)
  end

  test "#create renders errors and does not persist an invalid quote",
       %{conn: conn} do
    invalid_quote_changeset =
      Quote.changeset(%Quote{}, params_for(:invalid_quote))

    conn = post(
      conn,
      quote_path(conn, :create),
      quote: params_for(:invalid_quote)
    )

    assert json_response(conn, 422) ==
      render_changeset_json("error.json", changeset: invalid_quote_changeset)
    refute Repo.get_by(Quote, raw: params_for(:invalid_quote).raw)
  end

  test "#update renders the updated quote and persists a valid quote",
       %{conn: conn} do
    original_quote_attrs = %{raw: "^gOriginal quote"}
    updated_quote_attrs = %{raw: "^yUpdated quote"}
    original_quote = insert(:quote, original_quote_attrs)

    conn = patch(
      conn,
      quote_path(conn, :update, original_quote),
      quote: params_for(:quote, updated_quote_attrs)
    )

    updated_quote = Repo.get_by(Quote, raw: updated_quote_attrs.raw)
    assert json_response(conn, 200) ==
      render_json("show.json", quote: updated_quote)
    refute Repo.get_by(Quote, original_quote_attrs)
  end

  test "#update renders errors and does not persist an invalid quote",
       %{conn: conn} do
    valid_quote = insert(:quote)
    invalid_quote_changeset =
      Quote.changeset(%Quote{}, params_for(:invalid_quote))

    conn = patch(
      conn,
      quote_path(conn, :update, valid_quote),
      quote: params_for(:invalid_quote)
    )

    assert json_response(conn, 422) ==
      render_changeset_json("error.json", changeset: invalid_quote_changeset)
    refute Repo.get_by(Quote, raw: params_for(:invalid_quote).raw)
  end

  test "#delete deletes a quote", %{conn: conn} do
    quote = insert(:quote)

    conn = delete conn, quote_path(conn, :delete, quote)

    assert response(conn, 204)
    refute Repo.get(Quote, quote.id)
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
