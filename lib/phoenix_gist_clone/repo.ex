defmodule PhoenixGistClone.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_gist_clone,
    adapter: Ecto.Adapters.Postgres
end
