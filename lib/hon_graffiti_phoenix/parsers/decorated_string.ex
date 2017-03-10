defmodule HonGraffitiPhoenix.Parsers.DecoratedString do
  @moduledoc """
  Provides a struct for strings with hon style markdown
  """

  @enforce_keys [:body]
  defstruct [:body, color: "white"]
end
