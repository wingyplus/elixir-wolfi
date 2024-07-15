defmodule ElixirWolfi.Erlang do
  alias ElixirWolfi.Wolfi

  @doc """
  Fetch the source by given the `version`.
  """
  def source(dag, version) do
    dag
    |> Dagger.Client.git("https://github.com/erlang/otp.git")
    |> Dagger.GitRepository.tag("OTP-#{version}")
    |> Dagger.GitRef.tree()
  end

  @doc """
  Build the Erlang/OTP at the given `version`.
  """
  def build(dag, version) do
    dag
    |> Wolfi.base()
    |> Wolfi.with_packages(~w[
      autoconf
      automake
      build-base
      ca-certificates
      ncurses-dev
      openssl-dev
      wget
      zlib-dev
    ])
    |> Dagger.Container.with_mounted_directory("/OTP", source(dag, version))
    |> Dagger.Container.with_workdir("/OTP")
    # TODO: allows to configure some options through function argument.
    |> Dagger.Container.with_exec(~w[
      ./configure 
      --without-wx
      --without-jinterface
      --without-debugger
      --without-observer
      --without-et
      --with-ssl
      --enable-fips
      --enable-dirty-schedulers
    ])
    |> Dagger.Container.with_exec(~w"make -j")
    |> Dagger.Container.with_exec(~w"make install")
  end
end
