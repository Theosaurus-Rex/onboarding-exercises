defmodule Game do

  @dictionary [
    "pecan",
    "gecko",
    "ouija",
    "ocean",
    "delta"
  ]
  defstruct dictionary: @dictionary,
            max_turns: 6,
            secret_word: "pecan",
            guesses: []
end
