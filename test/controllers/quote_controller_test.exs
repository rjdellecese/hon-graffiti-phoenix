defmodule HonGraffitiPhoenix.HonQuoteControllerTest do
  use HonGraffitiPhoenix.ConnCase

  alias HonGraffitiPhoenix.HonQuote

  setup do
    %{conn: build_conn()}
  end

  test "#index renders a list of hon_quotes", %{conn: conn} do
    hon_quote = insert(:hon_quote)

    conn = get conn, hon_quote_path(conn, :index)

    assert json_response(conn, 200) ==
      render_json("index.json", hon_quotes: [hon_quote])
  end

  test "#show renders a single hon_quote", %{conn: conn} do
    hon_quote = insert(:hon_quote)

    conn = get conn, hon_quote_path(conn, :show, hon_quote)

    assert json_response(conn, 200) ==
      render_json("show.json", hon_quote: hon_quote)
  end

  test "#create renders and persists a valid hon_quote", %{conn: conn} do
    conn = post(
      conn, hon_quote_path(conn, :create), hon_quote: params_for(:hon_quote)
    )

    hon_quote = Repo.get_by(HonQuote, raw: params_for(:hon_quote).raw)
    assert json_response(conn, 201) ==
      render_json("show.json", hon_quote: hon_quote)
  end

  test "#create renders errors and does not persist an invalid hon_quote",
       %{conn: conn} do
    invalid_hon_quote_changeset =
      HonQuote.changeset(%HonQuote{}, params_for(:invalid_hon_quote))

    conn = post(
      conn,
      hon_quote_path(conn, :create),
      hon_quote: params_for(:invalid_hon_quote)
    )

    assert json_response(conn, 422) ==
      render_changeset_json(
        "error.json",
        changeset: invalid_hon_quote_changeset
      )
    refute Repo.get_by(HonQuote, raw: params_for(:invalid_hon_quote).raw)
  end

  test "#update renders the updated hon_quote and persists a valid hon_quote",
       %{conn: conn} do
    original_hon_quote_attrs = %{raw: "^gOriginal hon_quote"}
    updated_hon_quote_attrs = %{raw: "^yUpdated hon_quote"}
    original_hon_quote = insert(:hon_quote, original_hon_quote_attrs)

    conn = patch(
      conn,
      hon_quote_path(conn, :update, original_hon_quote),
      hon_quote: params_for(:hon_quote, updated_hon_quote_attrs)
    )

    updated_hon_quote = Repo.get(HonQuote, original_hon_quote.id)
    assert json_response(conn, 200) ==
      render_json("show.json", hon_quote: updated_hon_quote)
    assert updated_hon_quote.raw == updated_hon_quote_attrs.raw
  end

  test "#update renders errors and does not persist an invalid hon_quote",
       %{conn: conn} do
    valid_hon_quote = insert(:hon_quote)
    invalid_hon_quote_changeset =
      HonQuote.changeset(%HonQuote{}, params_for(:invalid_hon_quote))

    conn = patch(
      conn,
      hon_quote_path(conn, :update, valid_hon_quote),
      hon_quote: params_for(:invalid_hon_quote)
    )

    assert json_response(conn, 422) ==
      render_changeset_json(
        "error.json", changeset: invalid_hon_quote_changeset
      )
    valid_hon_quote = Repo.get(HonQuote, valid_hon_quote.id)
    refute valid_hon_quote.raw == params_for(:invalid_hon_quote).raw
  end

  test "#delete deletes a hon_quote", %{conn: conn} do
    hon_quote = insert(:hon_quote)

    conn = delete conn, hon_quote_path(conn, :delete, hon_quote)

    assert response(conn, 204)
    refute Repo.get(HonQuote, hon_quote.id)
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    HonGraffitiPhoenix.HonQuoteView.render(template, assigns)
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
