defmodule Theme01.Management do
  @moduledoc """
  The Management context.
  """

  import Ecto.Query, warn: false
  alias Theme01.Repo

  alias Theme01.Management.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Gets a single user by attributes.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_by_attr!("liam.fabiano@epitech.eu", "liam")

      %User{}
      iex> get_user_by_attr!("foo@gmail.com", "noOne")
      ** (Ecto.NoResultsError)
  """
  def get_user_by_attr!(email, username) do
    Repo.get_by!(User, [email: email, username: username])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def find_and_confirm_password(email, password) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, :not_found}
      user ->
        if Comeonin.Bcrypt.checkpw(password, user.password_hash) do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end

  alias Theme01.Management.Clock

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock!(id), do: Repo.get!(Clock, id)

  @doc """
    Get a clock by user id.

    Raises `Ecto.NoResultsError` if the Clock does not exist.

    ## Examples

        iex> get_clock!(123)
        %Clock{}
        iex> get_clock!(456)
        ** (Ecto.NoResultsError)

  """
  def get_clock_by_user(userID) do
    # Join user with clock
    query = from c in Clock,
      join: u in User,
      on: c.user_id == u.id,
      where: u.id == ^userID

    #Execute query
    Repo.one(query)
  end

  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clock(attrs \\ %{}, user) do
    %Clock{user: user}
    |> Ecto.Changeset.change()
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{data: %Clock{}}

  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end

  alias Theme01.Management.WorkingTime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%WorkingTime{}, ...]

  """
  def list_workingtimes do
    Repo.all(WorkingTime)
  end

  @doc """
  Gets a single working_time.

  Raises `Ecto.NoResultsError` if the Working time does not exist.

  ## Examples

      iex> get_working_time!(123)
      %WorkingTime{}

      iex> get_working_time!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time!(id), do: Repo.get!(WorkingTime, id)

  @doc """
  Gets a single working_time by user.

  Raises `Ecto.NoResultsError` if the Working time does not exist.

  ## Examples

      iex> get_working_time_by_user!(123)
      %WorkingTime{}

      iex> get_working_time_by_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time_by_user!(workingtimeID, userID) do
    query = from w in WorkingTime,
      where: w.id == ^workingtimeID,
      where: w.user_id == ^userID

    Repo.one(query)
  end

  @doc """
  Creates a working_time.

  ## Examples

      iex> create_working_time(%{field: value})
      {:ok, %WorkingTime{}}

      iex> create_working_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_working_time(attrs \\ %{}, user) do
    %WorkingTime{user: user}
    |> Ecto.Changeset.change()
    |> WorkingTime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a working_time.

  ## Examples

      iex> update_working_time(working_time, %{field: new_value})
      {:ok, %WorkingTime{}}

      iex> update_working_time(working_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a working_time.

  ## Examples

      iex> delete_working_time(working_time)
      {:ok, %WorkingTime{}}

      iex> delete_working_time(working_time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  @doc """
  Gets a single workingtime by its attributes start and end.
  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples
      iex> get_workingtime!(123)
      %Workingtime{}
      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)
  """
  def get_workingtime_by_attr(id, startTime, endTime) do
    # Join workingtime with user
    query = from w in WorkingTime,
      join: u in User,
      on: w.user_id == u.id,
      where: u.id == ^id

    # Is startTime null ?
    if !is_nil(startTime) do
      # Filter workingTime by startTime
      _query = from [w, u] in query,
      where: w.start >= ^startTime
    end
    # Is endTime null ?
    if !is_nil(endTime) do
      # Filter working time by endTime
      _query = from [w, u] in query,
      where: w.end <= ^endTime
    end
    # Execute query
    Repo.all(query)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_time changes.

  ## Examples

      iex> change_working_time(working_time)
      %Ecto.Changeset{data: %WorkingTime{}}

  """
  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end
end
