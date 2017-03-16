defmodule HonGraffitiPhoenix.Requests.HonApi do
  # require HTTPoison.Base
  # alias HTTPoison.Response
  import HTTPoison

  @moduledoc """
  Makes requests to the HoN servers and provides
  some convenience functions for dealing with return
  values.
  """

  @token Application.get_env(
    :hon_graffiti_phoenix, HonGraffitiPhoenix.HonApi
  )[:token]
  @base_url Application.get_env(
    :hon_graffiti_phoenix, HonGraffitiPhoenix.HonApi
  )[:api_root]

  @spec get_by_nickname(String.t) :: {atom, map}
  def get_by_nickname(nickname) do
    url = "#{@base_url}/player_statistics/all/nickname/#{nickname}/?token=#{@token}"
    get_request(url)
  end

  @spec get_by_id(number) :: {atom, map}
  def get_by_id(account_id) do
    url = "#{@base_url}/this/is/probably/not#{account_id}/it?token=#{@token}"
    get_request(url)
  end

  @spec account_exists?(String.t) :: boolean
  def account_exists?(nickname) do
    case get_by_nickname(nickname) do
      {:ok, account_info} ->
        Map.fetch!(account_info, "account_id") != 0
    end
  end

  defp get_request(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.Parser.parse!(body)}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, %{:reason => "403"}}
      {:ok, %HTTPoison.Response{status_code: 403}} ->
        {:error, %{:reason => "404"}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{:reason => reason}}
    end
  end

end
