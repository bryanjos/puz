defmodule PuzTest do
  use ExUnit.Case
  doctest Puz

  test "greets the world" do
    assert Puz.hello() == :world
  end
end
