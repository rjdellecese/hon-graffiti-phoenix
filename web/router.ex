defmodule HonGraffitiPhoenix.Router do
  use HonGraffitiPhoenix.Web, :router

  # pipeline :browser do
  #   plug :accepts, ["html"]
  #   plug :fetch_session
  #   plug :fetch_flash
  #   plug :protect_from_forgery
  #   plug :put_secure_browser_headers
  # end

  # scope "/", HonGraffitiPhoenix do
  #   pipe_through :browser
  # end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HonGraffitiPhoenix do
    pipe_through :api

    resources "/quotes", QuoteController, only: [:index, :show]
  end
end
