defmodule ElixirWolfi.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_wolfi,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ElixirWolfi.Application, []}
    ]
  end

  defp deps do
    [
      {:dagger, path: "../dagger_sdk"}
    ]
  end
end
