defmodule Theme01Web.SessionController do
  use Theme01Web, :controller

  alias Theme01.Management

  action_fallback Theme01Web.FallbackController

  def sign_in(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Management.find_and_confirm_password(email, password) do
      {:ok, user} ->
        custom_claim = %{ user: %{id: user.id, role: user.role} }
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, :api, custom_claim)
        conn
        |> render("sign_in.json", user: user, jwt: jwt)
      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", message: "Could not login")
    end
  end
end
