defmodule Theme01.Repo.Migrations.CreateUsers do
  use Ecto.Migration
  import EctoEnum

  defenum RolesEnum, :role, [:employee, :manager, :admin]

  def change do
    RolesEnum.create_type
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password_hash, :string
      add :role, RolesEnum.type(), default: "employee"

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
