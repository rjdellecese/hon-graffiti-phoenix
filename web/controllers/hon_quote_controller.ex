defmodule HonGraffitiPhoenix.HonQuoteController do
  use HonGraffitiPhoenix.Web, :controller

  alias HonGraffitiPhoenix.HonQuote

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def index(conn, _params) do
    hon_quotes = Repo.all(HonQuote)
    render(conn, "index.json", hon_quotes: hon_quotes)
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def show(conn, %{"id" => id}) do
    hon_quote = Repo.get!(HonQuote, id)
    render(conn, "show.json", hon_quote: hon_quote)
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def create(conn, %{"hon_quote" => hon_quote_params}) do
    changeset = HonQuote.changeset(%HonQuote{}, hon_quote_params)

    case Repo.insert(changeset) do
      {:ok, hon_quote} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", hon_quote_path(conn, :show, hon_quote))
        |> render("show.json", hon_quote: hon_quote)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(
             HonGraffitiPhoenix.ChangesetView,
             "error.json",
             changeset: changeset
           )
    end
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def update(conn, %{"id" => id, "hon_quote" => hon_quote_params}) do
    hon_quote = Repo.get!(HonQuote, id)
    changeset = HonQuote.changeset(hon_quote, hon_quote_params)

    case Repo.update(changeset) do
      {:ok, hon_quote} ->
        render(conn, "show.json", hon_quote: hon_quote)
      {:error, _hon_quote} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(
             HonGraffitiPhoenix.ChangesetView,
             "error.json",
             changeset: changeset
           )
    end
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def delete(conn, %{"id" => id}) do
    hon_quote = Repo.get!(HonQuote, id)

    Repo.delete!(hon_quote)

    send_resp(conn, :no_content, "")
  end
end
