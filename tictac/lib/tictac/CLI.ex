defmodule Tictac.CLI do
    alias Tictac.{State, CLI}

    #Starts the entire app
    def play() do
        Tictac.start(&CLI.handle/2)
    end

    def handle(%State{status: :initial}, :get_player) do
        IO.gets("Which player will go first, x or o?")
        |> String.trim
        |> String.to_atom
    end

    def handle(%State{status: :playing} = state, :request_move) do
        display_board(state.board)
        IO.puts("What's #{state.turn}'s next move?")
        
    end

    #Helper method to render tokens placed on board 
    def show(board, c, r) do
        [item] = for {%{col: col, row: row}, value} <- board,
                col == c, row == r, do: value
        if item == :empty, do: " ", else: to_string(item)
    end

    def display_board(b) do
        IO.puts """
        #{show(b, 1, 1)} | #{show(b, 2, 1)} | #{show(b, 3, 1)}
        ----------
        #{show(b, 1, 2)} | #{show(b, 2, 2)} | #{show(b, 3, 2)}
        ----------
        #{show(b, 1, 3)} | #{show(b, 2, 3)} | #{show(b, 3, 3)}
        """
    end
end