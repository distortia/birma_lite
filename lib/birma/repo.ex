defmodule Birma.Repo do
  use Ecto.Repo,
    otp_app: :birma,
    adapter: Ecto.Adapters.Postgres
end
