defmodule CarDealershipWeb.Router do
  use CarDealershipWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CarDealershipWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CarDealershipWeb do
    pipe_through :browser

    live "/categories", CategoryLive.Index, :index
    live "/categories/new", CategoryLive.Index, :new
    live "/categories/:id/edit", CategoryLive.Index, :edit

    live "/categories/:id", CategoryLive.Show, :show
    live "/categories/:id/show/edit", CategoryLive.Show, :edit

    live "/categories/:id/models", CategoryLive.Show, :add_models

    # live "/categories/:id/models/:model_id", ModelLive.Show, :show
    live "/models/:id/add_cars", ModelLive.Show, :add_cars

    live "/models", ModelLive.Index, :index
    live "/models/new", ModelLive.Index, :new
    live "/models/:id/edit", ModelLive.Index, :edit

    live "/models/:id", ModelLive.Show, :show
    live "/models/:id/show/edit", ModelLive.Show, :edit

    live "/models/:id/models", ModelLive.Show, :add_models

    live "/", HomeLive.Index, :index
    # live "/cars", CarLive.Index, :index
    # # live "/cars/new", CarLive.Index, :new
    # # live "/cars/:id/edit", CarLive.Index, :edit

    # live "/cars/:id", CarLive.Show, :show
    # live "/cars/:id/show/edit", CarLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", CarDealershipWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CarDealershipWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
