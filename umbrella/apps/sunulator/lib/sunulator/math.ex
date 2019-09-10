defmodule Sunulator.Math do
  def pi, do: :math.pi()

  def sin(rad), do: :math.sin(rad)
  def sind(rad), do: sin(tod(rad))

  def asin(rad), do: :math.asin(rad)
  def asind(rad), do: asin(tod(rad))

  def cos(rad), do: :math.cos(rad)
  def cosd(rad), do: cos(tod(rad))

  def acos(rad), do: :math.acos(rad)
  def acosd(rad), do: acos(tod(rad))

  def tan(rad), do: :math.tan(rad)
  def tand(rad), do: tan(tod(rad))

  def atan(rad), do: :math.atan(rad)
  def atand(rad), do: atan(tod(rad))

  defp tod(rad), do: rad * pi() / 180
end
