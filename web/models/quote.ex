defmodule HonGraffitiPhoenix.Quote do
  use HonGraffitiPhoenix.Web, :model

  schema "quotes" do
    field :raw, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:raw])
    |> validate_required([:raw])
  end
end
