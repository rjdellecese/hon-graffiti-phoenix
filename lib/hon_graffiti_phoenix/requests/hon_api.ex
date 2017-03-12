defmodule HonGraffitiPhoenix.Requests.HonApi do

  @token Application.get_env(:hon_graffiti_phoenix, HonGraffitiPhoenix.HonApi)[:token]
  @base_url Application.get_env(:hon_graffiti_phoenix, HonGraffitiPhoenix.HonApi)[:api_root]

  def get_account(nickname) do
    url = "#{@base_url}/player_statistics/all/nickname/#{nickname}/?token=#{@token}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.Parser.parse!(body)}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, 404}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

end
