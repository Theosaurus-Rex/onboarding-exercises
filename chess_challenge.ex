defmodule Chess do
  # Every instance of Square must have the row and col keys
  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @board_size 1..8

  # Make a new square when both col and row are in range 1 to 3
  def new(col, row) when col in @board_size and row in @board_size do
    {:ok, %Chess{row: row, col: col}}
  end

  # Handle params outside of valid range
  def new(_row, _col), do: {:error, :invalid_square}

  # Create a list of squares set to empty, which get put into a map
  def new_board do
    for s <- squares(), into: %{}, do: {s, :empty}
  end

  # Create the squares for the game board
  def squares do
    for c <- @board_size, r <- @board_size, into: MapSet.new(), do: %Chess{col: c, row: r}
  end

  def rook_attacks(board, col, row) do
    for {%{col: c, row: r}, _value} = s <- board,
        # Exclude the square the rook is on with xor
        :erlang.xor(col == c, row == r),
        do: s
  end

  def bishop_attacks(board, col, row) do
    for {%{col: c, row: r}, _value} = s <- board,
        # Column minus row of piece should be the same as column minus row of attacking square
        # c - r gives the downward slope, c + r gives the upward slope
        # Exclude square the bishop is on with xor
        :erlang.xor(c - r == col - row, c + r == col + row),
        do: s
  end

  def knight_attacks(board, col, row) do
    for {%{col: c, row: r}, _value} = s <- board,
      #Attack square is one col two rows off, or one row two cols off from location
        ((abs(c - col) == 2) and (abs(r - row) == 1)) or
        ((abs(c - col) == 1) and (abs(r - row) == 2)),
        do: s
  end
end
