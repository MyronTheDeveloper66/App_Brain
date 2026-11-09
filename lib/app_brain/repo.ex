defmodule AppBrain.Repo do
  use Ecto.Repo,
    otp_app: :app_brain,
    adapter: Ecto.Adapters.Postgres
end
