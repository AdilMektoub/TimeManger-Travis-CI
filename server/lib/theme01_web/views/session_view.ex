defmodule Theme01Web.SessionView do
  use Theme01Web, :view

  def render("sign_in.json", %{user: user, jwt: jwt}) do
    %{
      status: :ok,
      data: %{
        token: jwt,
        id: user.id
      },
      message: "You are successfully logged in."
    }
  end

  def render("error.json",  %{message: message}) do
    %{
      status: :error,
      data: %{
        message: message
      }
    }
  end
end