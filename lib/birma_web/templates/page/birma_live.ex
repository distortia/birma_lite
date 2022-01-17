defmodule BirmaWeb.BirmaLive do
 use Phoenix.LiveView

 def render(assigns) do
  ~H"""
  <h1 class="text-center">My Plan</h1>
    <div class="container mx-auto my-10">
      <div class="flex flex-row gap-4">
        <%= for {date, meals} <- @plan do %>
          <div class="container mx-auto rounded-lg border-2 border-slate-100">
            <h1 class="text-lg"><%= format_day_of_week(date) %></h1>
            <%= for meal <- meals do %>

              <h2 class="text-2xl">
                <%= meal.name %>
              </h2>

              <%= for ingredient <- meal.ingredients do %>
                <ul>
                  <li><%= ingredient.name %></li>
                </ul>
              <% end %>

              <button
                class="rounded bg-teal-500 w-full my-4"
                phx-click="made"
                phx-value-meal-id={meal.id}
                >
                I made this
              </button>

              <%= if length(meals) > 1 do %>
                <hr>
              <% end %>
            <% end %>
          </div>
        <% end %>
      </div>
    </div>
  """
  end

  def mount(_params, _, socket) do
    plan = Birma.fetch_meals_within_week()
    socket = socket |> assign(plan: plan)
    {:ok, socket}
  end

  def handle_event("made", %{"meal-id" => meal_id}, socket) do

    Birma.made_meal(meal_id)

    {:noreply, socket}
  end

  def format_day_of_week(1), do: "Monday"
  def format_day_of_week(2), do: "Tuesday"
  def format_day_of_week(3), do: "Wednesday"
  def format_day_of_week(4), do: "Thursday"
  def format_day_of_week(5), do: "Friday"
  def format_day_of_week(6), do: "Saturday"
  def format_day_of_week(7), do: "Sunday"
  def format_day_of_week(date), do: date |> Date.day_of_week() |> format_day_of_week()
end
