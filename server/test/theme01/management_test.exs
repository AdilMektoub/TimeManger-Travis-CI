defmodule Theme01.ManagementTest do
  use Theme01.DataCase

  alias Theme01.Management

  describe "users" do
    alias Theme01.Management.User

    @valid_attrs %{email: "some email", username: "some username"}
    @update_attrs %{email: "some updated email", username: "some updated username"}
    @invalid_attrs %{email: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Management.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Management.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Management.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Management.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Management.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Management.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Management.update_user(user, @invalid_attrs)
      assert user == Management.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Management.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Management.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Management.change_user(user)
    end
  end

  describe "clocks" do
    alias Theme01.Management.Clock

    @valid_attrs %{status: true, time: ~N[2010-04-17 14:00:00]}
    @update_attrs %{status: false, time: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{status: nil, time: nil}

    def clock_fixture(attrs \\ %{}) do
      {:ok, clock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Management.create_clock()

      clock
    end

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Management.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Management.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      assert {:ok, %Clock{} = clock} = Management.create_clock(@valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2010-04-17 14:00:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Management.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{} = clock} = Management.update_clock(clock, @update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2011-05-18 15:01:01]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Management.update_clock(clock, @invalid_attrs)
      assert clock == Management.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Management.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Management.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Management.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias Theme01.Management.WorkingTime

    @valid_attrs %{end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{end: nil, start: nil}

    def working_time_fixture(attrs \\ %{}) do
      {:ok, working_time} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Management.create_working_time()

      working_time
    end

    test "list_workingtimes/0 returns all workingtimes" do
      working_time = working_time_fixture()
      assert Management.list_workingtimes() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert Management.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      assert {:ok, %WorkingTime{} = working_time} = Management.create_working_time(@valid_attrs)
      assert working_time.end == ~N[2010-04-17 14:00:00]
      assert working_time.start == ~N[2010-04-17 14:00:00]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Management.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{} = working_time} = Management.update_working_time(working_time, @update_attrs)
      assert working_time.end == ~N[2011-05-18 15:01:01]
      assert working_time.start == ~N[2011-05-18 15:01:01]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = Management.update_working_time(working_time, @invalid_attrs)
      assert working_time == Management.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = Management.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> Management.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = Management.change_working_time(working_time)
    end
  end
end
