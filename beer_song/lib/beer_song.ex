defmodule BeerSong do
  @spec verse(non_neg_integer()) :: binary
  def verse(2),
    do: """
    2 bottles of beer on the wall, 2 bottles of beer.
    Take one down and pass it around, 1 bottle of beer on the wall.
    """

  def verse(1),
    do: """
    1 bottle of beer on the wall, 1 bottle of beer.
    Take it down and pass it around, no more bottles of beer on the wall.
    """

  def verse(0),
    do: """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """

  def verse(n) do
    """
    #{n} bottles of beer on the wall, #{n} bottles of beer.
    Take one down and pass it around, #{n - 1} bottles of beer on the wall.
    """
  end

  @spec lyrics(Enumerable.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
