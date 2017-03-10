defmodule HonGraffitiPhoenix.Parsers.DecoratedString do
  @moduledoc """
  Provides a struct for strings with hon style markup
  """

  @enforce_keys [:body]
  defstruct [:body, color: "white"]
end
