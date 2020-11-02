defmodule Theme01Web.RegistrationView do
  use Theme01Web, :view
  alias Theme01Web.UserView

  def render("success.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end
end