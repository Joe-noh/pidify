# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :pidify, PidifyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gkGi0dNFDLLbcom6mfg/bdlX/B+zA6lCrccLltpACfhBv/+q2IOMOMxANj/Rq8aL",
  render_errors: [view: PidifyWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Pidify.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :pidify, :wkhtmltopdf_path, Map.get(System.get_env(), "WKHTMLTOPDF_PATH", "wkhtmltopdf")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
