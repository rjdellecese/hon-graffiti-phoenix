defmodule HonGraffitiPhoenix.QuoteController do
  use HonGraffitiPhoenix.Web, :controller

  alias HonGraffitiPhoenix.Quote

  @lint {Credo.Check.Readability.Specs, false}
  def index(conn, _params) do
    quotes = Repo.all(Quote)
    render(conn, "index.json", quotes: quotes)
  end

  @lint {Credo.Check.Readability.Specs, false}
  def show(conn, %{"id" => id}) do
    quote = Repo.get!(Quote, id)
    render(conn, "show.json", quote: quote)
  end

  @lint {Credo.Check.Readability.Specs, false}
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

  @lint {Credo.Check.Readability.Specs, false}
  def update(conn, %{"id" => id, "quote" => quote_params}) do
    quote = Repo.get!(Quote, id)
    changeset = Quote.changeset(quote, quote_params)

    case Repo.update(changeset) do
      {:ok, quote} ->
        render(conn, "show.json", quote: quote)
      {:error, _quote} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(
             HonGraffitiPhoenix.ChangesetView,
             "error.json",
             changeset: changeset
           )
    end
  end

  @lint {Credo.Check.Readability.Specs, false}
  def delete(conn, %{"id" => id}) do
    quote = Repo.get!(Quote, id)

    Repo.delete!(quote)

    send_resp(conn, :no_content, "")
  end
end
