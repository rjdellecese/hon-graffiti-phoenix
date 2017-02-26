defmodule HonGraffitiPhoenix.QuoteTest do
  use HonGraffitiPhoenix.ModelCase

  alias HonGraffitiPhoenix.Quote

  @a_long_string List.duplicate("Wahooo", 30) |> List.to_string

  @short_attrs %{raw: "ab"}
  @long_attrs %{raw: @a_long_string}
  @valid_attrs %{raw: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Quote.changeset(%Quote{}, @valid_attrs)
    assert changeset.valid?
  end

  test "validate requires at least a minumum length" do
    changeset = Quote.changeset(%Quote{}, @short_attrs)
    refute changeset.valid?
  end

  test "validate requires less than a maximum length" do
    changeset = Quote.changeset(%Quote{}, @long_attrs)
    refute changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Quote.changeset(%Quote{}, @invalid_attrs)
    refute changeset.valid?
  end
end
