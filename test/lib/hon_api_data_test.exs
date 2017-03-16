defmodule HonGraffitiPhoenix.HonApiDataTest do
  use HonGraffitiPhoenix.ConnCase
  alias HonGraffitiPhoenix.Requests.HonApiData

  @data %{"data" => "parsedStuffTODO"}

  test "it can determine if an account exists" do
    valid_account = Map.put(@data, "account_id", 33)

    status = HonApiData.account_exists?(valid_account)

    assert status
  end

  test "it can determin if account does not exist" do
    invalid_account = Map.put(@data, "account_id", 0)

    status = HonApiData.account_exists?(invalid_account)

    refute status
  end


end
