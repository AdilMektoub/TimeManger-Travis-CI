defmodule Theme01Web.ClockView do
  use Theme01Web, :view
  alias Theme01Web.ClockView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{id: clock.id,
      time: clock.time,
      status: clock.status,
      user: render_one(clock.user, Theme01Web.UserView, "user.json")}
  end
end
