ExUnit.start

ExUnit.configure exclude: [external: true]

Ecto.Adapters.SQL.Sandbox.mode(HonGraffitiPhoenix.Repo, :manual)
