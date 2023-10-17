defmodule CarDealershipWeb.Router do
  use CarDealershipWeb, :router

  import CarDealershipWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CarDealershipWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
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

    live "/cars/:id", ModelLive.Show, :show
    live "/cars/:id/add_quote", ModelLive.Show, :add_quote
    live "/models/:id/show/edit", ModelLive.Show, :edit

    live "/models/:id/models", ModelLive.Show, :add_models

    live "/", HomeLive.Index, :index

    live "/listings", ListingLive.Index, :index

    live "/blogs", BlogLive.Index, :index
    live "/blogs/new", BlogLive.Index, :new
    live "/blogs/:id/edit", BlogLive.Index, :edit

    live "/blogs/:id", BlogLive.Show, :show
    live "/blogs/:id/show/edit", BlogLive.Show, :edit

    live "/quotes", QuoteLive.Index, :index
    live "/quotes/new", QuoteLive.Index, :new
    live "/quotes/:id/edit", QuoteLive.Index, :edit

    live "/quotes/:id", QuoteLive.Show, :show
    live "/quotes/:id/show/edit", QuoteLive.Show, :edit
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

  ## Authentication routes

  scope "/", CarDealershipWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", CarDealershipWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", CarDealershipWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
