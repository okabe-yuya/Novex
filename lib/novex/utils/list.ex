defmodule Novex.Utils.List do
  @moduledoc """
    Utils functions for List
  """

  @doc """
    convert 2dim list to 1dim list
  """
  def one_dim_zip([]), do: []
  def one_dim_zip([[]]), do: []
  def one_dim_zip(lst) do
    Enum.reduce(lst, [], fn inner_lst, acc ->
      Enum.concat(acc, inner_lst)
    end)
  end

  @doc """
    slice list, top to speced value of index
  """
  def until(lst, str), do: _until(lst, str, [], lst)
  defp _until([], _str, _acc, lst), do: [[], lst]
  defp _until([h | t], str, acc, _base) when h == str, do: [acc ++ [h], t]
  defp _until([h | t], str, acc, base), do: _until(t, str, acc ++ [h], base)

  @doc """
    fetch last value and return remove last value
  """
  def split_last(lst), do: _split_last(lst, [])
  defp _split_last([], _), do: {nil, []}
  defp _split_last([h], acc), do: {h, Enum.reverse(acc)}
  defp _split_last([h | t], acc), do: _split_last(t, [h | acc])
end
