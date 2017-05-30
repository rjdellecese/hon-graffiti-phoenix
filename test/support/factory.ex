defmodule HonGraffitiPhoenix.Factory do
  use ExMachina.Ecto, repo: HonGraffitiPhoenix.Repo

  def hon_quote_factory do
    %HonGraffitiPhoenix.HonQuote{
      raw: "^rI am red. ^095I am sea green. ^*I am the normal color."
    }
  end

  def invalid_hon_quote_factory do
    %HonGraffitiPhoenix.HonQuote{raw: "^r"}
  end
end
