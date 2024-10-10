defmodule Communer.Hexer do
  use GenServer
  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_) do
    state = %{
      requests: [],
      config: :hex_core.default_config()
    }
    {:ok, state}
  end

  def request!(module, function, arguments, callback) do
    GenServer.cast(__MODULE__, {:action, {module, function, arguments}, callback})
  end

  def handle_cast({:action, mfa, callback}, %{requests: requests} = state) do
    Logger.info("Scheduling Hexer request: #{inspect(mfa)}")
    schedule_run(1)
    {:noreply, %{state | requests: requests ++ [{mfa, callback}]}}
  end

  def handle_info(:run, %{requests: []} = state), do: {:noreply, state}

  def handle_info(:run, %{requests: [{mfa, callback} | tail]} = state) do
    Logger.info("Running Hex request: #{inspect(mfa)}")
    {module, function, args} = mfa
    args = [state.config | args]
    case apply(module, function, args) do
      {:ok, {200, _, data}} ->
        data
        |> Enum.map(&Map.new/1)
        |> callback.()
        schedule_run(1)
      err ->
        schedule_run(5000)
        Logger.warning("Hex request (#{inspect(mfa)}) failed: #{inspect(err)}")
    end
    {:noreply, %{state | requests: tail}}
  end

  defp schedule_run(delay) do
    Process.send_after(self(), :run, delay)
  end
end
