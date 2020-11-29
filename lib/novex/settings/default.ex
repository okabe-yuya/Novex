defmodule Novex.Settings.Default do
  @moduledoc """
    functions return default settings of values
  """
  def punctuation, do: ["、", "。", ",", "."]
  def rest_time, do: 100
  def end_string, do: ""
end
