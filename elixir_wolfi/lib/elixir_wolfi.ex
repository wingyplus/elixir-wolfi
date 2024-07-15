defmodule ElixirWolfi do
  @moduledoc """
  A Dagger module for building Elixir and Erlang/OTP docker image based on Wolfi.
  """

  use Dagger.Mod, name: "ElixirWolfi"

  alias ElixirWolfi.Wolfi
  alias ElixirWolfi.Erlang

  defstruct [:dag]

  @function [
    args: [
      otp_version: [type: :string],
      elixir_version: [type: :string]
    ],
    return: Dagger.Container
  ]
  @doc """
  Build the Elixir docker image.
  """
  def elixir(self, args) do
    otp_container = erlang(self, args)
    otp_container
  end

  @function [
    args: [
      otp_version: [type: :string]
    ],
    return: Dagger.Container
  ]
  @doc """
  Build the Erlang/OTP docker image.
  """
  def erlang(self, args) do
    version = args.otp_version

    unless String.starts_with?(version, "27") do
      raise ArgumentError, "Erlang/OTP supports only version 27 (or higher)."
    end

    self.dag
    |> Wolfi.base()
    |> Wolfi.with_packages(~w[
      ca-certificates
      ncurses
      libstdc++
    ])
    |> Dagger.Container.with_directory(
      "/usr/local",
      Erlang.build(self.dag, version) |> Dagger.Container.directory("/usr/local")
    )
  end
end
