defmodule HonGraffitiPhoenix.Requests.HonRequest do
  alias HTTPoison.Response
  alias Poison.Parser

  @moduledoc """
  Makes requests to the HoN servers and provides
  raw return data. The goal is as little functionality
  as possible to minimize mocking api calls.
  """

  @token Application.get_env(
    :hon_graffiti_phoenix, HonGraffitiPhoenix.HonApi
  )[:token]
  @base_url Application.get_env(
    :hon_graffiti_phoenix, HonGraffitiPhoenix.HonApi
  )[:api_root]

  @spec account_by_nickname(String.t) :: {atom, map}
  def account_by_nickname(nickname) do
    url = "#{@base_url}/player_statistics/all/nickname/#{nickname}/?token=#{@token}"
    get_request(url)
  end

  @spec account_by_id(number) :: {atom, map}
  def account_by_id(account_id) do
    url = "#{@base_url}/this/is/probably/not#{account_id}/it?token=#{@token}"
    get_request(url)
  end

  defp get_request(url) do
    case HTTPoison.get(url) do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, Parser.parse!(body)}
      {:ok, %Response{status_code: 404}} ->
        {:error, %{:reason => "403"}}
      {:ok, %Response{status_code: 403}} ->
        {:error, %{:reason => "404"}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{:reason => reason}}
    end
  end

end
