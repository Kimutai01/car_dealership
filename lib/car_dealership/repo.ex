defmodule CarDealership.Repo do
  use Ecto.Repo,
    otp_app: :car_dealership,
    adapter: Ecto.Adapters.Postgres
end
