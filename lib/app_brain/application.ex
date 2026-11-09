defmodule AppBrain.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AppBrainWeb.Telemetry,
      AppBrain.Repo,
      {DNSCluster, query: Application.get_env(:app_brain, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AppBrain.PubSub},
      # Start a worker by calling: AppBrain.Worker.start_link(arg)
      # {AppBrain.Worker, arg},
      # Start to serve requests, typically the last entry
      AppBrainWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AppBrain.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AppBrainWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
