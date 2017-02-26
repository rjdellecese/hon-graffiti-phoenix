defmodule HonGraffitiPhoenix.QuoteController do
  use HonGraffitiPhoenix.Web, :controller

  alias HonGraffitiPhoenix.Quote

  @lint {Credo.Check.Readability.Specs, false}
  def index(conn, _params) do
    quotes = Repo.all(Quote)
    render(conn, "index.html", quotes: quotes)
  end

  @lint {Credo.Check.Readability.Specs, false}
  def new(conn, _params) do
    changeset = Quote.changeset(%Quote{})
    render(conn, "new.html", changeset: changeset)
  end

  @lint {Credo.Check.Readability.Specs, false}
  def create(conn, %{"quote" => quote_params}) do
    changeset = Quote.changeset(%Quote{}, quote_params)

    case Repo.insert(changeset) do
      {:ok, _quote} ->
        conn
        |> put_flash(:info, "Quote created successfully.")
        |> redirect(to: quote_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @lint {Credo.Check.Readability.Specs, false}
  def show(conn, %{"id" => id}) do
    quote = Repo.get!(Quote, id)
    render(conn, "show.html", quote: quote)
  end

  @lint {Credo.Check.Readability.Specs, false}
  def edit(conn, %{"id" => id}) do
    quote = Repo.get!(Quote, id)
    changeset = Quote.changeset(quote)
    render(conn, "edit.html", quote: quote, changeset: changeset)
  end

  @lint {Credo.Check.Readability.Specs, false}
  def update(conn, %{"id" => id, "quote" => quote_params}) do
    quote = Repo.get!(Quote, id)
    changeset = Quote.changeset(quote, quote_params)

    case Repo.update(changeset) do
      {:ok, quote} ->
        conn
        |> put_flash(:info, "Quote updated successfully.")
        |> redirect(to: quote_path(conn, :show, quote))
      {:error, changeset} ->
        render(conn, "edit.html", quote: quote, changeset: changeset)
    end
  end

  @lint {Credo.Check.Readability.Specs, false}
  def delete(conn, %{"id" => id}) do
    quote = Repo.get!(Quote, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(quote)

    conn
    |> put_flash(:info, "Quote deleted successfully.")
    |> redirect(to: quote_path(conn, :index))
  end
end
