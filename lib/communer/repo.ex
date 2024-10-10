defmodule Communer.Repo do
  use Ecto.Repo,
    otp_app: :communer,
    adapter: Ecto.Adapters.Postgres
end
