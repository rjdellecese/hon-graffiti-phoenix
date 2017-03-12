defmodule HonGraffitiPhoenix.RequestTest do
  use HonGraffitiPhoenix.ConnCase
  alias HonGraffitiPhoenix.Requests.HonApi

  test "it can make requests" do
    {:ok, results} = HonApi.get_account("sylverhand")
    IO.inspect results
    IO.puts "account id!"
    IO.puts Map.fetch!(results, "account_id")
    IO.inspect Map.keys(results)
    assert 1 == 2
  end

end
