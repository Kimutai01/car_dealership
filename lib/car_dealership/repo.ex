defmodule CarDealership.Repo do
  use Ecto.Repo,
    otp_app: :car_dealership,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 5
end
