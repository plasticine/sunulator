defmodule Sunulator.Math do
  defmodule Trig do
    def to_degrees(radians), do: radians * :math.pi() / 180
    def to_radians(degrees), do: degrees * 180 / :math.pi()

    def sin(angle), do: :math.sin(angle)
    def asin(angle), do: :math.asin(angle)
    def cos(angle), do: :math.cos(angle)
    def acos(angle), do: :math.acos(angle)
    def tan(angle), do: :math.tan(angle)
    def atan(angle), do: :math.atan(angle)

    def sind(angle), do: sin(to_radians(angle))
    def asind(angle), do: asin(to_radians(angle))

    def cosd(angle), do: cos(to_radians(angle))
    def acosd(angle), do: acos(to_radians(angle))

    def tand(angle), do: tan(to_radians(angle))
    def atand(angle), do: atan(to_radians(angle))
  end
end
