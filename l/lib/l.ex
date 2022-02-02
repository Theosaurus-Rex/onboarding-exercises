
defmodule L do
  def count(list), do: count(list, 0)

  def count([], acc), do: acc
  def count([ _head | tail ], acc), do: count(tail, acc + 1)

  def reverse(list), do: reverse_helper(list, [])
  defp reverse_helper([], acc), do: acc
  defp reverse_helper([ head | tail ], acc), do: reverse_helper(tail, [head | acc])

  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  def filter([], _fun), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def reduce([], value, _func), do: value
  def reduce([ head | tail ], value, func), do: reduce(tail, func.(head, value), func)

end
