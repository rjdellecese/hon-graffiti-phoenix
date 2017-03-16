defmodule HonGraffitiPhoenix.RequestTest do
  use HonGraffitiPhoenix.ConnCase
  alias HonGraffitiPhoenix.Requests.HonApi


  @tag :external
  test "it can fail to make requests" do
    nickname = "break Stuff%/"

    {:error, results} = HonApi.get_by_nickname(nickname)

    assert Map.has_key?(results, :reason)
  end

  @tag :external
  test "it can verify real accounts" do
    nickname = "shamshirz"

    {:ok, results} = HonApi.get_by_nickname(nickname)

    assert Map.fetch!(results, "account_id") != 0
  end

  @tag :external
  test "it can verify fake accounts don't exist" do
    nickname = "shamshirzThisNameIsTooLong"

    {:ok, results} = HonApi.get_by_nickname(nickname)

    assert Map.fetch!(results, "account_id") == 0
  end

  @tag :external
  test "it has a convenience method to check account existeance" do
    nickname = "shamshirz"

    results = HonApi.account_exists?(nickname)

    assert results
  end


end
