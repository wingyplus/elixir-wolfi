defmodule ElixirWolfi.Wolfi do
  @doc """
  Wolfi base image.
  """
  def base(dag) do
    dag
    |> Dagger.Client.container()
    |> Dagger.Container.from("cgr.dev/chainguard/wolfi-base")
  end

  @doc """
  Install Wolfi packages.
  """
  def with_packages(container, packages) do
    container
    |> Dagger.Container.with_exec(["apk", "add"] ++ packages)
  end
end
