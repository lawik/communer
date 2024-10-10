defmodule Communer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CommunerWeb.Telemetry,
      Communer.Repo,
      {DNSCluster, query: Application.get_env(:communer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Communer.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Communer.Finch},
      Communer.Githubber,
      Communer.Hexer,
      # Start a worker by calling: Communer.Worker.start_link(arg)
      # {Communer.Worker, arg},
      # Start to serve requests, typically the last entry
      CommunerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Communer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CommunerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
