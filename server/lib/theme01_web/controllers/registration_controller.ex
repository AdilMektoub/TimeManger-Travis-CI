defmodule Theme01Web.RegistrationController do
  use Theme01Web, :controller

  alias Theme01.Management.User
  alias Theme01.Repo

  action_fallback Theme01Web.FallbackController

  def sign_up(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("success.json", user: user)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(Theme01Web.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end
end
