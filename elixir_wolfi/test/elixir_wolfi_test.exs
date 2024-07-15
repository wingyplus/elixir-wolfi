defmodule ElixirWolfiTest do
  use ExUnit.Case
  doctest ElixirWolfi

  test "greets the world" do
    assert ElixirWolfi.hello() == :world
  end
end
