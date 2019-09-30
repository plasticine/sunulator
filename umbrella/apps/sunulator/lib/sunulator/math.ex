defmodule Sunulator.Math do
  defmodule Trig do
    @spec pi :: float
    defdelegate pi, to: :math

    @rad_in_deg (180/:math.pi)

    @doc """
    Converts degrees to radians

    ## Examples
        iex> Math.deg2rad(180)
        3.141592653589793

    """
    @spec deg2rad(number) :: float
    def deg2rad(x), do: x / @rad_in_deg

    @doc """
    Converts radians to degrees

    ## Examples
        iex> Math.rad2deg(Math.pi)
        180.0
    """
    @spec rad2deg(number) :: float
    def rad2deg(x), do: x * @rad_in_deg

    @doc """
    Computes the sine of *x*.

    *x* is interpreted as a value in radians.
    """
    @spec sin(number) :: float
    defdelegate sin(x), to: :math

    @doc """
    Computes the cosine of *x*.

    *x* is interpreted as a value in radians.
    """
    @spec cos(number) :: float
    defdelegate cos(x), to: :math

    @doc """
    Computes the tangent of *x* (expressed in radians).
    """
    @spec tan(number) :: float
    defdelegate tan(x), to: :math

    @doc """
    Computes the arc sine of *x*. (expressed in radians)
    """
    @spec asin(number) :: float
    defdelegate asin(x), to: :math

    @doc """
    Computes the arc cosine of *x*. (expressed in radians)
    """
    @spec acos(number) :: float
    defdelegate acos(x), to: :math

    @doc """
    Computes the arc tangent of *x*. (expressed in radians)
    """
    @spec atan(number) :: float
    defdelegate atan(x), to: :math

    @doc """
    Computes the arc tangent given *y* and *x*. (expressed in radians)
    This variant returns the inverse tangent in the correct quadrant, as the signs of both *x* and *y* are known.
    """
    @spec atan2(number, number) :: float
    defdelegate atan2(y, x), to: :math

    # Advanced Trigonometry

    @doc """
    Computes the hyperbolic sine of *x* (expressed in radians).
    """
    @spec sinh(number) :: float
    defdelegate sinh(x), to: :math

    @doc """
    Computes the hyperbolic cosine of *x* (expressed in radians).
    """
    @spec cosh(number) :: float
    defdelegate cosh(x), to: :math

    @doc """
    Computes the hyperbolic tangent of *x* (expressed in radians).
    """
    @spec tanh(number) :: float
    defdelegate tanh(x), to: :math

    @doc """
    Computes the inverse hyperbolic sine of *x*.
    """
    @spec asinh(number) :: float
    defdelegate asinh(x), to: :math

    @doc """
    Computes the inverse hyperbolic cosine of *x*.
    """
    @spec acosh(number) :: float
    defdelegate acosh(x), to: :math

    @doc """
    Computes the inverse hyperbolic tangent of *x*.
    """
    @spec atanh(number) :: float
    defdelegate atanh(x), to: :math
  end
end
