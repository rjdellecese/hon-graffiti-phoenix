defmodule HonGraffitiPhoenix.QuoteController do
  use HonGraffitiPhoenix.Web, :controller

  alias HonGraffitiPhoenix.Quote

  @lint {Credo.Check.Readability.Specs, false}
  def index(conn, _params) do
    quotes = Repo.all(Quote)
    render(conn, "index.json", quotes: quotes)
  end

  def show(conn, %{"id" => id}) do
    quote = Repo.get!(Quote, id)
    render(conn, "show.json", quote: quote)
  end

  def create(conn, %{"quote" => quote_params}) do
    changeset = Quote.changeset(%Quote{}, quote_params)

    case Repo.insert(changeset) do
      {:ok, quote} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", quote_path(conn, :show, quote))
        |> render("show.json", quote: quote)
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
end
