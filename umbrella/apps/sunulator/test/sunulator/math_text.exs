defmodule Sunulator.MathTest do
  use ExUnit.Case, async: true
  alias Sunulator.Math

  @degrees 45
  @radians 0.7853981633974483

  test "Trig.rad2deg/1" do
    assert Math.Trig.rad2deg(@radians) == @degrees
  end

  test "Trig.deg2rad/1" do
    assert Math.Trig.deg2rad(@degrees) == @radians
  end

  test "Trig.sin/1" do
    assert Math.Trig.sin(1) == 0.8414709848078965
  end

  test "Trig.asin/1" do
    assert Math.Trig.asin(1) == 1.570796326794896619231321691639751442098584699687552910487
  end

  test "Trig.cos/1" do
    assert Math.Trig.cos(1) == 0.540302305868139717400936607442976603732310420617922227670
  end

  test "Trig.acos/1" do
    assert Math.Trig.acos(1) == 0
  end

  test "Trig.tan/1" do
    assert Math.Trig.tan(1) == 1.557407724654902
  end

  test "Trig.atan/1" do
    assert Math.Trig.atan(1) == 0.785398163397448309615660845819875721049292349843776455243
  end
end
