defmodule Birma.Repo.Migrations.SetupWorld do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string
      add :url, :string
      add :scheduled_date, :date
      add :last_made, :date
      add :times_made, :integer

      timestamps()
    end

    create table(:ingredients) do
      add :name, :string

      timestamps()
    end

    create table(:meals_ingredients) do
      add :meal_id, references(:meals)
      add :ingredient_id, references(:ingredients)

      timestamps()
    end

    create unique_index(:meals_ingredients, [:meal_id, :ingredient_id])
  end
end
