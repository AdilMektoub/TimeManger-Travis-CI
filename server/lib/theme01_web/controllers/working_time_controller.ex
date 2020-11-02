defmodule Theme01Web.WorkingTimeController do
  use Theme01Web, :controller

  alias Theme01.Management
  alias Theme01.Management.WorkingTime
  alias Theme01.Repo

  action_fallback Theme01Web.FallbackController

  def index(conn, _params) do
    workingtimes = Management.list_workingtimes() |> Repo.preload(:user)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def createUserID(conn, %{"userID" => userID, "working_time" => working_time_params}) do
    user = Management.get_user!(userID)
    with {:ok, %WorkingTime{} = working_time} <- Management.create_working_time(working_time_params, user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, userID, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def show(conn, %{"userID" => userID, "workingtimeID" => workingtimeID}) do
    working_time = Management.get_working_time_by_user!(workingtimeID, userID) |> Repo.preload(:user)
    render(conn, "show.json", working_time: working_time)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = Management.get_working_time!(id) |> Repo.preload(:user)

    with {:ok, %WorkingTime{} = working_time} <- Management.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = Management.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- Management.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end

  def show_by_attr(conn, %{"userID" => id, "start" => _startTime, "end" => _endTime}) do
    # Get params and init
    params = conn.query_params
    startTime = nil
    endTime = nil

    if Map.has_key?(params, "start") and !is_nil(Map.get(params, "start")) and !String.equivalent?(Map.get(params, "start"), '') do
      _startTime = Map.get(params, "start")
      |> NaiveDateTime.from_iso8601!()
    end
    if Map.has_key?(params, "end") and !is_nil(Map.get(params, "end")) and !String.equivalent?(Map.get(params, "end"), '') do
      _endTime = Map.get(params, "end")
      |> NaiveDateTime.from_iso8601!()
    end
    workingtimes = Management.get_workingtime_by_attr(id, startTime, endTime) |> Repo.preload(:user)
    render(conn, "index.json", workingtimes: workingtimes)
  end
end
