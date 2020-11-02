defmodule Theme01Web.UserController do
  use Theme01Web, :controller

  alias Theme01.Management
  alias Theme01.Management.User

  action_fallback Theme01Web.FallbackController

  def index(conn, _params) do
    users = Management.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Management.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"userID" => id}) do
    user = Management.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"userID" => id, "user" => user_params}) do
    user = Management.get_user!(id)

    with {:ok, %User{} = user} <- Management.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"userID" => id}) do
    user = Management.get_user!(id)

    with {:ok, %User{}} <- Management.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def show_by_attr(conn, %{}) do
    params = conn.query_params

    if Map.has_key?(params, "email") and Map.has_key?(params, "username") do
      user = Management.get_user_by_attr!(Map.get(params, "email"), Map.get(params, "username"))
      render(conn, "show.json", user: user)
    end
  end
end
