defmodule PhoenixGistClone.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixGistCloneWeb.Telemetry,
      PhoenixGistClone.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_gist_clone, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixGistClone.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixGistClone.Finch},
      # Start a worker by calling: PhoenixGistClone.Worker.start_link(arg)
      # {PhoenixGistClone.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixGistCloneWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixGistClone.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixGistCloneWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
