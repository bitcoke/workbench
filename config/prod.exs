use Mix.Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :workbench, WorkbenchWeb.Endpoint,
  # TODO:
  # For testing liveview on localhost. Once actually deployed set it to a real domain
  url: [host: "localhost", port: 4000],
  # url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :workbench, WorkbenchWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [
#         :inet6,
#         port: 443,
#         cipher_suite: :strong,
#         keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#         certfile: System.get_env("SOME_APP_SSL_CERT_PATH")
#       ]
#
# The `cipher_suite` is set to `:strong` to support only the
# latest and more secure SSL ciphers. This means old browsers
# and clients may not be supported. You can set it to
# `:compatible` for wider support.
#
# `:keyfile` and `:certfile` expect an absolute path to the key
# and cert in disk or a relative path inside priv, for example
# "priv/ssl/server.key". For all supported SSL configuration
# options, see https://hexdocs.pm/plug/Plug.SSL.html#configure/1
#
# We also recommend setting `force_ssl` in your endpoint, ensuring
# no data is ever sent via http, always redirecting to https:
#
#     config :workbench, WorkbenchWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# Finally import the config/prod.secret.exs which loads secrets
# and configuration from environment variables.
import_config "prod.secret.exs"

# Tai
config :tai, advisor_groups: %{}

config :tai,
  venues: %{
    binance: [
      start_on_boot: true,
      adapter: Tai.VenueAdapters.Binance,
      timeout: 120_000,
      products: "btc_usdc btc_usdt eth_btc ltc_btc eos_btc",
      credentials: %{
        main: %{
          api_key: {:system_file, "BINANCE_API_KEY"},
          secret_key: {:system_file, "BINANCE_API_SECRET"}
        }
      }
    ],
    bitmex: [
      start_on_boot: true,
      adapter: Tai.VenueAdapters.Bitmex,
      timeout: 120_000,
      products: "ethm20 ltcm20 eosm20",
      credentials: %{
        main: %{
          api_key: {:system_file, "BITMEX_API_KEY"},
          api_secret: {:system_file, "BITMEX_API_SECRET"}
        }
      }
    ],
    okex: [
      start_on_boot: true,
      adapter: Tai.VenueAdapters.OkEx,
      timeout: 60_000,
      products: "btc_usdt btc_usd_swap btc_usdt_swap btc_usd_200626 btc_usdt_200626 okb_usdt",
      accounts: "ada bch btc eos etc eth link ltc okb pax trx tusd usdc usdk usdt xrp",
      credentials: %{
        main: %{
          api_key: {:system_file, "OKEX_API_KEY"},
          api_secret: {:system_file, "OKEX_API_SECRET"},
          api_passphrase: {:system_file, "OKEX_API_PASSPHRASE"}
        }
      }
    ]
  }

config :workbench,
  balance_snapshot: %{
    enabled: true,
    btc_usd_venue: :binance,
    btc_usd_symbol: :btc_usdc,
    usd_quote_venue: :binance,
    usd_quote_asset: :usdt,
    quote_pairs: [binance: :usdt, okex: :usdt]
  }

config :logger_json, :backend, metadata: :all
config :logger, backends: [LoggerJSON], level: :info
