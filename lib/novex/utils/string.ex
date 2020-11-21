defmodule Novex.Utils.String do
  @moduledoc """
    Utils functions for String
  """

  @doc """
    String to code point list
  """
  def to_list(str), do: String.codepoints(str)
end
