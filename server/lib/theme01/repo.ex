defmodule Theme01.Repo do
  use Ecto.Repo,
    otp_app: :theme01,
    adapter: Ecto.Adapters.Postgres
end
