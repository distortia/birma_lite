defmodule BirmaWeb.PlanLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    Current meal plan
    <div class="grid">
      <%= for meal <- @plan do %>
        <%= meal.name %>
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
        </div>
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    plan = Birma.fetch_meals_within_week()
    meals = Birma.fetch_meals()
    socket = socket |> assign(meals: meals, plan: plan)
    {:ok, socket}
  end
end
