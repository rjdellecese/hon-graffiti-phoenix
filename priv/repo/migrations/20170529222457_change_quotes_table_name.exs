defmodule HonGraffitiPhoenix.Repo.Migrations.ChangeQuotesTableName do
  use Ecto.Migration

  def change do
    rename table(:quotes), to: table(:hon_quotes)
  end
end
