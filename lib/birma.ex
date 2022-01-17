defmodule Birma do
  alias Birma.{Ingredient, Meal, MealsIngredients}

  def get_meal(meal_id) do
    Meal.get(meal_id)
  end

  def fetch_meals() do
    Meal.fetch()
  end

  def fetch_meals_within_week() do
    Meal.fetch_week()
  end

  def made_meal(meal_id) do
    Meal.made(meal_id)
  end

  def add_meal_to_plan(meal_id, scheduled_date) do
    Meal.add_to_plan(meal_id, scheduled_date)
  end

  def remove_meal_from_plan(meal_id) do
    Meal.remove_from_plan(meal_id)
  end
end
