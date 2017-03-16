defmodule HonGraffitiPhoenix.Requests.HonApiData do
  @moduledoc """
  Set of convenience functions for handling the HoNApi
  response and returning more managable data.
  """

  @spec account_exists?(map) :: boolean
  def account_exists?(account_info), do: Map.fetch!(account_info, "account_id") != 0

end
