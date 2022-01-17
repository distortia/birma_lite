defmodule Birma.MealsIngredients do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birma.{Ingredient, Meal, Repo}

  schema "meals_ingredients" do
    belongs_to :meal, Meal, on_replace: :delete
    belongs_to :ingredient, Ingredient, on_replace: :delete

    timestamps()
  end

  def changeset(meal_ingredient, attrs) do
    meal_ingredient
    |> cast(attrs, [:meal_id, :ingredient_id])
    |> validate_required([:meal_id, :ingredient_id])
  end

  def add(meal, ingredient) do
    %__MODULE__{}
    |> changeset(%{meal_id: meal.id, ingredient_id: ingredient.id})
    |> Repo.insert()
  end
end
