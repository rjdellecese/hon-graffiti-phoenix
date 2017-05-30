defmodule HonGraffitiPhoenix.ErrorView do
  use HonGraffitiPhoenix.Web, :view

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def render("404.html", _assigns) do
    "Page not found"
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def render("500.html", _assigns) do
    "Internal server error"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
