defmodule Theme01Web.ClockController do
  use Theme01Web, :controller

  alias Theme01.Management
  alias Theme01.Management.Clock
  alias Theme01.Management.User
  alias Theme01.Repo

  action_fallback Theme01Web.FallbackController

  def index(conn, _params) do
    clocks = Management.list_clocks() |> Repo.preload(:user)
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Management.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"userID" => userID}) do
    clock = Management.get_clock_by_user(userID) |> Repo.preload(:user)
    render(conn, "show.json", clock: clock)
  end

  def handle_clock(conn, %{"userID" => userID}) do
    # Get clock by userID and get User
    clock = Management.get_clock_by_user(userID) |> Repo.preload(:user)
    user = Repo.get!(User, userID)

    # Is the user working for the first time ? (No clock registered with the userID)
    if is_nil(clock) do
      # Clock'in (status = true) and set the new startTime to clock_params
      clock_params = %{time: NaiveDateTime.utc_now(), status: true}
      # Create new clock with the new status and the new StartTime
      with {:ok, %Clock{} = clock} <- Management.create_clock(clock_params, user) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, userID))
        |> render("show.json", clock: clock)
      end
    else
        # Is the user not working?
       if !clock.status do
        # Clock'in (status = true) and set the new startTime to clock_params
        clock_params = %{time: NaiveDateTime.utc_now(), status: true}
        #  Save/Update the new status and the new StartTime
        Management.update_clock(clock, clock_params)
      else
         # Get the time from now
         endTime = NaiveDateTime.utc_now()
         # Clock out (status = false) and set the endTime to clock_params
         clock_params = %{time: endTime, status: false}
         # Work finished: Create new working time
         Management.create_working_time(%{start: clock.time, end: endTime}, user)
         # Save/Update the new status and the new EndTime
         Management.update_clock(clock, clock_params)
      end
    end
    render(conn, "show.json", clock: clock)
  end
end
