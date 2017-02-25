defmodule HonGraffitiPhoenix.PageController do
  use HonGraffitiPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def about(conn, _param) do
    render conn, "about.html"
  end
end
