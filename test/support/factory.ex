defmodule HonGraffitiPhoenix.Factory do
  use ExMachina.Ecto, repo: HonGraffitiPhoenix.Repo

  def quote_factory do
    %HonGraffitiPhoenix.Quote{
      raw: "^rI am red. ^095I am sea green. ^*I am the normal color."
    }
  end
end
