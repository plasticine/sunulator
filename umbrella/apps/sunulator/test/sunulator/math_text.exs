defmodule Sunulator.MathTest do
  use ExUnit.Case, async: true
  alias Sunulator.Math

  @degrees = 45
  @radians = 0.7853981633974483

  test "Trig.to_degrees/1" do
    assert Math.Trig.to_degrees(@radians) == @degrees
  end

  test "Trig.to_radians/1" do
    assert Math.Trig.to_radians(@degrees) == @radians
  end

  test "Trig.sin/1" do
    assert Math.Trig.sin(@radians) == @degrees
  end

  test "Trig.sind/1" do

  end

  test "Trig.asin/1" do

  end

  test "Trig.asind/1" do

  end

  test "Trig.cos/1" do
    assert Math.Trig.cos(@radians) == @degrees
  end

  test "Trig.cosd/1" do

  end

  test "Trig.acos/1" do

  end

  test "Trig.acosd/1" do

  end

  test "Trig.tan/1" do
    assert Math.Trig.tan(@radians) == @degrees
  end

  test "Trig.tand/1" do

  end

  test "Trig.atan/1" do

  end

  test "Trig.atand/1" do

  end
end
