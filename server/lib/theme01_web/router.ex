defmodule Theme01Web.Router do
  use Theme01Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :authenticated do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", Theme01Web do
    pipe_through :api

    post "/sign_up", RegistrationController, :sign_up
    post "/sign_in", SessionController, :sign_in

    pipe_through :authenticated
    scope "/users" do
      post "/", UserController, :create
      get "/", UserController, :show_by_attr
      get "/all", UserController, :index
      get "/:userID", UserController, :show
      put "/:userID", UserController, :update
      delete "/:userID", UserController, :delete
    end

    scope "/workingtimes" do
      get "/all", WorkingTimeController, :index
      get "/:userID", WorkingTimeController, :show_by_attr
      get "/:userID/:workingtimeID", WorkingTimeController, :show
      post "/:userID", WorkingTimeController, :createUserID
      put "/:id", WorkingTimeController, :update
      delete "/:id", WorkingTimeController, :delete
    end

    scope "/clocks" do
      get "/all", ClockController, :index
      get "/:userID", ClockController, :show
      post "/:userID", ClockController, :handle_clock
    end
  end
end
