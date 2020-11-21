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
end
