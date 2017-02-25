defmodule HonGraffitiPhoenix.Repo.Migrations.CreateQuote do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :raw, :string

      timestamps()
    end

  end
end
