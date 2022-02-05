defmodule Tictac.Square do
    alias Tictac.Square
    #Every instance of Square must have the row and col keys
    @enforce_keys [ :row, :col]
    defstruct [:row, :col]

    @board_size 1..3

    #Make a new square when both col and row are in range 1 to 3
    def new(col, row) when col in @board_size and row in @board_size do
        {:ok, %Square{row: row, col: col}}
    end

    #Handle params outside of valid range
    def new(_row, _col), do: {:error, :invalid_square}

    #Create a list of squares set to empty, which get put into a map
  def new_board do
    for s <- squares(), into: %{}, do: {s, :empty}
  end

  #Create the squares for the game board 
  def squares do
    for c <- @board_size, r <- @board_size, into: MapSet.new(), do: %Square{col: c, row: r}
  end
end