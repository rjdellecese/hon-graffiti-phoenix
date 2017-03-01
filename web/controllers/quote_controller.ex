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
end
