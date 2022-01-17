defmodule Birma.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birma.{Meal, Repo}

  schema "ingredients" do
    field :name, :string

    many_to_many :meals, Meal, join_through: "meals_ingredients"

    timestamps()
  end

  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def add(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end
end
