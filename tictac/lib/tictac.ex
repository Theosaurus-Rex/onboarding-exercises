defmodule Tictac do
  @moduledoc """
  Documentation for `Tictac`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Tictac.hello()
      :world

  """
  alias Tictac.{Square, State}
    
  #Start a new game using a UI
  def start(ui) do
    {:ok, game} = State.new(ui)
    player = ui.(game, :get_player)
    {:ok, game} = State.event(game, {:choose_p1, player})
    game
  end

  #Check which symbol the player is, handle invalid symbol
  def check_player(player) do
    case player do
      :x -> {:ok, player}
      :o -> {:ok, player}
      _  -> {:error, :invalid_player}
    end
  end

  def handle(%{status: :playing} = game) do
    with {col, row} <- game.ui.(game, :request_move),
        {:ok, board} <- play_at(game.board, col, row, game.turn),
        {:ok, game} <- State.event(%{game | board: board}, {:play, game.turn}),
        do: game
  end

  def place_piece(board, place, player) do
    #Lookup square on board
    case board[place] do
      nil -> {:error, :invalid_location}
      :x  -> {:error, :occupied}
      :o  -> {:error, :occupied}
      :empty -> {:ok, %{board | place => player}}
      _  -> {:error, :invalid_player}
    end
  end

  def play_at(board, col, row, player) do
    with  {:ok, valid_player} <- check_player(player),
          {:ok, square} <- Square.new(col, row),
          {:ok, new_board} <- place_piece(board, square, valid_player),
      do: new_board
  end

end
