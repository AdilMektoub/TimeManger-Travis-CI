defmodule Theme01.Management.User do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  defenum RolesEnum, :role, [:employee, :manager, :admin]

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :role, RolesEnum, default: "employee"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :role])
    |> validate_required([:email, :username, :password, :role])
    |> unique_constraint(:email)
    |> validate_changeset
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :role])
    |> validate_required([:email, :username, :password, :role])
    |> validate_changeset
  end

  @doc false
  defp validate_changeset(user) do
    user
    |> validate_length(:email, min: 5, max: 255)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> validate_format(:password, ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*/, [message: "Must include at least one lowercase letter, one uppercase letter, and one digit"])
    |> generate_password_hash
  end

  @doc false
  defp generate_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
