defmodule Tictac.State do
    alias Tictac.{Square, State}
    @players [:x, :o]

    defstruct   status: :initial,
                turn: nil,
                winner: nil,
                board: Square.new_board(),
                ui: nil

    def new(), do: {:ok, %State{}}
    def new(ui), do: {:ok, %State{ui: ui}}

    #Deal with initial game state, pick who goes first
    def event(%State{status: :initial} = state, {:choose_p1, player}) do
        #If player successfully returned it becomes their turn to play
        case Tictac.check_player(player) do
            {:ok, player} -> {:ok, %State{state | status: :playing, turn: player}}
            _ -> {:error, :invalid_player}
        end
    end

    #Playing begins but player invalid
    def event(%State{status: :playing}, {:play, player}) when player not in @players do
        {:error, :invalid_player}
    end

    #Player matches the player whose turn it currently is
    #Need to swap to the other player's turn after a play is made
    def event(%State{status: :playing, turn: player} = state, {:play, player}) do
        {:ok, %State{state | turn: other_player(player)}}
    end

    #Return error if current player is not the correct player
    def event(%State{status: :playing}, {:play, _}), do: {:error, :out_of_turn}

    def event(%State{status: :playing} = state, {:check_for_winner, winner}) do
        win_state = %State{state | status: :game_over, turn: nil, winner: winner}
        case winner do
            :x -> {:ok, win_state}
            :o -> {:ok, win_state}
            _ -> {:ok, state}
        end
    end

    #Check if game is over and update state if it is
    def event(%State{status: :playing} = state, {:game_over?, over_or_not}) do
        case over_or_not do
            :not_over -> {:ok, state}
            :game_over -> {:ok, %State{state |status: :game_over, winner: :tie}}
            _ -> {:error, :invalid_game_over_status}
        end
    end

    def event(%State{status: :game_over} = state, {:game_over?, _}) do
        {:ok, state}
    end

    #Catch-all for handling exceptions
    def event(state, action) do
        {:error, {:invalid_state_transition, %{status: state.status, action: action}}}
    end

    #Helper method to swap players each turn
    def other_player(player) do
        case player do
            :x -> :o
            :o -> :x
            _ -> {:error, :invalid_player}
        end
    end
end