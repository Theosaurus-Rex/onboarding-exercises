defmodule Wordle do
  @spec guess(binary, binary) :: list

  def guess(player_guess, secret_word) do
    secret_letters = String.to_charlist(secret_word)

    {result, _} =
      player_guess
      |> String.to_charlist()
      |> Enum.zip(secret_letters)
      |> Enum.reduce({[], secret_letters}, fn {guess_letter, secret_letter},
                                                    {result, secret_letters} ->
        letter_result = check_letter(guess_letter, secret_letter, secret_letters)
        {[letter_result | result], secret_letters -- [guess_letter]}
      end)

    Enum.reverse(result)
  end

  @spec check_letter(any, any, any) ::
          {:correct, binary} | {:incorrect, binary} | {:partial, binary}

  def check_letter(guess_letter, secret_letter, secret_letters) do
    cond do
      guess_letter == secret_letter -> {:correct, to_string([guess_letter])}
      guess_letter in secret_letters -> {:partial, to_string([guess_letter])}
      true -> {:incorrect, to_string([guess_letter])}
    end
  end
end
