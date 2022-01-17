# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Birma.Repo.insert!(%Birma.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Birma.{Meal, MealsIngredients, Ingredient, Repo}

{:ok, tacos} = Meal.add(%{name: "Tacos", scheduled_date: Date.utc_today(), times_made: 1, last_made: Date.utc_today() |> Date.add(-7)})
{:ok, pico} = Meal.add(%{name: "Pico De Gallo", scheduled_date: Date.utc_today(), times_made: 1, last_made: Date.utc_today() |> Date.add(-7)})
{:ok, steak} = Meal.add(%{name: "Steak", scheduled_date: Date.add(Date.utc_today(), -1)})
{:ok, burgers} = Meal.add(%{name: "Burgers", scheduled_date: Date.add(Date.utc_today(), -2)})
{:ok, sausage_and_cabbage} = Meal.add(%{name: "Sausage and Cabbage with Bacon", scheduled_date: Date.add(Date.utc_today(), 1)})
{:ok, skipped} = Meal.add(%{name: "Skipped"})

{:ok, beef} = Ingredient.add(%{name: "Ground Beef"})
{:ok, onion} = Ingredient.add(%{name: "Onion"})
{:ok, pepper} = Ingredient.add(%{name: "Bell Pepper"})
{:ok, cilantro} = Ingredient.add(%{name: "Cilantro"})
{:ok, tomato} = Ingredient.add(%{name: "Tomato"})
{:ok, sausage} = Ingredient.add(%{name: "Sausage"})
{:ok, cabbage} = Ingredient.add(%{name: "Cabbage"})
{:ok, bacon} = Ingredient.add(%{name: "Bacon"})


MealsIngredients.add(tacos, beef)
MealsIngredients.add(tacos, onion)
MealsIngredients.add(tacos, pepper)

MealsIngredients.add(pico, onion)
MealsIngredients.add(pico, cilantro)
MealsIngredients.add(pico, tomato)

MealsIngredients.add(sausage_and_cabbage, sausage)
MealsIngredients.add(sausage_and_cabbage, cabbage)
MealsIngredients.add(sausage_and_cabbage, bacon)

MealsIngredients.add(burgers, beef)
