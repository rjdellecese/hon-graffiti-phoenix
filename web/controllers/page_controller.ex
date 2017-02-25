defmodule HonGraffitiPhoenix.PageController do
  use HonGraffitiPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
