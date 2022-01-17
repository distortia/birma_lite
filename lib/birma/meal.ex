defmodule Birma.Meal do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  alias Birma.Repo

  schema "meals" do
    field :name, :string
    field :url, :string
    field :scheduled_date, :date
    field :last_made, :date
    field :times_made, :integer, default: 0

    many_to_many :ingredients, Birma.Ingredient, join_through: "meals_ingredients", on_replace: :delete

    timestamps()
  end

  def changeset(meal, attrs) do
    meal
    |> cast(attrs, [:name, :url, :scheduled_date, :last_made, :times_made])
    |> validate_required([:name])
  end

  def get(id) do
    Repo.get(__MODULE__, id)
  end

  def add(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def fetch(query \\ __MODULE__) do
    query
    |> Repo.all()
    |> Repo.preload(:ingredients)
  end

  def fetch_week() do
    first_day = Date.utc_today() |> Date.add(-3)
    last_day = Date.utc_today() |> Date.add(3)
    from(m in __MODULE__,
    where: m.scheduled_date >= ^first_day and m.scheduled_date <= ^last_day,
    order_by: [asc: m.scheduled_date]
    )
    |> fetch()
    |> Enum.group_by(& &1.scheduled_date)
  end

  def made(meal_id) do
    meal = get(meal_id)

    meal
    |> changeset(%{
      times_made: meal.times_made + 1,
      last_made: meal.scheduled_date,
      })
    |> Repo.update()
  end
end
