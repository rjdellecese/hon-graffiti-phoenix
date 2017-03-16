defmodule HonGraffitiPhoenix.HonApiTest do
  use HonGraffitiPhoenix.ConnCase
  alias HonGraffitiPhoenix.Requests.HonApi


  @tag :external
  test "it can report a request failure" do
    nickname = "break Stuff%/"

    {:error, results} = HonApi.get_by_nickname(nickname)

    assert Map.has_key?(results, :reason)
  end

  @tag :external
  test "it can report a request success" do
    nickname = "shamshirz"

    {:ok, results} = HonApi.get_by_nickname(nickname)

    assert Map.fetch!(results, "account_id") != 0
  end

  @tag :external
  test "it can return a parsed successful response body" do
    nickname = "shamshirzThisNameIsTooLong"

    {:ok, results} = HonApi.get_by_nickname(nickname)

    assert Map.has_key?(results, "account_id")
  end

end
