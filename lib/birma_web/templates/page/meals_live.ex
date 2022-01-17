defmodule BirmaWeb.MealsLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
      Meals
    """
  end

  def mount(_params, _session, socket) do
    meals = Birma.fetch_meals()

    socket = assign(socket, meals: meals)
    {:ok, socket}
  end
end
