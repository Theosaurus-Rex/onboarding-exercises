defmodule L do
  def count(list), do: count(list, 0)

  def count([], acc), do: acc
  def count([_head | tail], acc), do: count(tail, acc + 1)

  def reverse(list), do: do_reverse(list, [])
  defp do_reverse([], acc), do: acc
  defp do_reverse([head | tail], acc), do: do_reverse(tail, [head | acc])

  def map(list, fun), do: map(list, fun, [])
  def map([], _fun, acc), do: reverse(acc)
  def map([head | tail], fun, acc), do: map(tail, fun, [fun.(head) | acc])

  def filter(list, fun), do: filter(list, fun, [])
  def filter([], _fun, acc), do: reverse(acc)
  def filter([head | tail], fun, acc) do
    if(fun.(head), do: filter(tail, fun, [head | acc]), else: filter(tail, fun, acc))
  end

  def reduce([], value, _func), do: value
  def reduce([head | tail], value, func), do: reduce(tail, func.(head, value), func)

  def append([], []), do: []
  def append([], list), do: list
  def append(list, []), do: list
  def append(list1, list2), do: append(reverse(list1), list2, list2)
  def append([], _list2, acc), do: acc
  def append([h1 | t1], list2, acc) do
    append(t1, list2, [h1 | acc])
  end

  def concat([]), do: []
  def concat(list), do: concat([], [], list)
  def concat(acc, [], []), do: reverse(acc)
  # Once element is empty, process the rest
  def concat(acc, rest, []), do: concat(acc, [], rest)
  #Skip empty lists
  def concat(acc, rest, [[] | tail]), do: concat(acc, rest, tail)
  #Push the tail into the "rest" to separate out the head
  def concat(acc, rest, [head | tail]) when is_list(head), do: concat(acc, [tail | rest], head)
  #Add head to accumulator
  def concat(acc, rest, [head | tail]), do: concat([head | acc], rest, tail)
end
