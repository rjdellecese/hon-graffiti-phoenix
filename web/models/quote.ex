defmodule HonGraffitiPhoenix.Quote do
  @moduledoc """
  A quote is a single line of HoN markup. The :raw field is the raw HoN markup.
  """
  use HonGraffitiPhoenix.Web, :model

  schema "quotes" do
    field :raw, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @lint {Credo.Check.Readability.Specs, false}
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:raw])
    |> validate_required([:raw])
    |> validate_length(:raw, min: 3)
    |> validate_length(:raw, max: 140)
  end
end
