defmodule HonGraffitiPhoenix.Router do
  use HonGraffitiPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HonGraffitiPhoenix do
    pipe_through :browser # Use the default browser stack

    resources "/", QuoteController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HonGraffitiPhoenix do
  #   pipe_through :api
  # end
end
