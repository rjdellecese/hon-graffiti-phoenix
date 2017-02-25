defmodule HonGraffitiPhoenix.QuoteControllerTest do
  use HonGraffitiPhoenix.ConnCase

  alias HonGraffitiPhoenix.Quote
  @valid_attrs %{raw: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, quote_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing quotes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, quote_path(conn, :new)
    assert html_response(conn, 200) =~ "New quote"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, quote_path(conn, :create), quote: @valid_attrs
    assert redirected_to(conn) == quote_path(conn, :index)
    assert Repo.get_by(Quote, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, quote_path(conn, :create), quote: @invalid_attrs
    assert html_response(conn, 200) =~ "New quote"
  end

  test "shows chosen resource", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = get conn, quote_path(conn, :show, quote)
    assert html_response(conn, 200) =~ "Show quote"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, quote_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = get conn, quote_path(conn, :edit, quote)
    assert html_response(conn, 200) =~ "Edit quote"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = put conn, quote_path(conn, :update, quote), quote: @valid_attrs
    assert redirected_to(conn) == quote_path(conn, :show, quote)
    assert Repo.get_by(Quote, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = put conn, quote_path(conn, :update, quote), quote: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit quote"
  end

  test "deletes chosen resource", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = delete conn, quote_path(conn, :delete, quote)
    assert redirected_to(conn) == quote_path(conn, :index)
    refute Repo.get(Quote, quote.id)
  end
end
