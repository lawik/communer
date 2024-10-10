defmodule CommunerWeb.HomeLive do
  use CommunerWeb, :live_view

  alias Communer.Hex

  require Logger

  def mount(_, _, socket) do
    Phoenix.PubSub.subscribe(Communer.PubSub, "package_created")
    {:ok, socket}
  end

  def handle_event("fetch-popular", _, socket) do
    Hex.fetch_popular()
    {:noreply, socket}
  end

  def handle_info(event, socket) do
    Logger.info("Got event: #{inspect(event)}")
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <button phx-click="fetch-popular">Fetch most popular</button>
    """
  end
end
