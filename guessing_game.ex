defmodule GuessingGame do
  def guess(low, high) do
    IO.puts(low)
    IO.puts(high)
  end

  def mid(low, high) do
    div(low + high, 2)
  end

  def bigger(low, high) do
    new_low = min(high, mid(low, high) + 1)
    guess(new_low, high)
  end
end
