defmodule Birma do
  alias Birma.{Ingredient, Meal, MealsIngredients}

  def fetch_meals() do
    Meal.fetch()
  end

  def fetch_meals_within_week() do
    Meal.fetch_week()
  end

  def made_meal(meal_id) do
    Meal.made(meal_id)
  end
end
