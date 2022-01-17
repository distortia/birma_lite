defmodule BirmaWeb.PlanLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    Current meal plan
    <div>
      Start date: <input class="text-black" type="date" name="start_date" id="" value={@start_date}>
    </div>
    <div class="grid" grid-cols-7>
    <%= for {meal, index} <- Enum.with_index(@plan) do %>
      <div>
        <%= meal.scheduled_date %> <%= meal.name %> - <button phx-click="remove" phx-value-plan-index={index} phx-value-meal-id={meal.id}>x</button>
      </div>
      <% end %>
    </div>
    <hr>
    <h1 class="text-center">Meals</h1>

    <div class="grid grid-cols-4">
      <%= for meal <- @meals do %>
        <div class="container mx-auto rounded-lg border-2 border-slate-100">
          <h2 class="text-2xl"><%= meal.name %></h2>
          <%= for ingredient <- meal.ingredients do %>
            <ul>
              <li><%= ingredient.name %></li>
            </ul>
          <% end %>
          <button class="rounded bg-teal-500 w-full my-4" phx-click="add" phx-value-meal-id={meal.id}>Add to plan</button>
        </div>
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    start_date = Date.utc_today()
    plan = []
    meals = Birma.fetch_meals()
    socket = socket |> assign(meals: meals, plan: plan, start_date: start_date)
    {:ok, socket}
  end

  def handle_event("add", %{"meal-id" => meal_id}, socket) do
    start_date = socket.assigns.start_date
    current_plan = socket.assigns.plan
    scheduled_date = start_date |> Date.add(length(current_plan))
    {:ok, meal} = Birma.add_meal_to_plan(meal_id, scheduled_date)
    new_plan = current_plan ++ [meal]
    socket = socket |> assign(plan: new_plan)
    {:noreply, socket}
  end

  def handle_event("remove", %{"meal-id" => meal_id, "plan-index" => index}, socket) do
    #TODO: Shuffle scheduled_date if we remove something
    {:ok, _meal} = Birma.remove_meal_from_plan(meal_id)
    plan = List.delete_at(socket.assigns.plan, String.to_integer(index))

    socket = socket |> assign(plan: plan)
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
