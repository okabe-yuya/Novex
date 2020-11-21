defmodule Novex.Writer.Novel do
  @moduledoc """
    tmp
  """

  use GenServer

  @doc """
    Launch GenServer no stack or set stack
  """
  def init, do: _init([])
  def init(content) when is_binary(content) do
    to_novel_list(content) |> _init()
  end
  def init(contents) when is_list(contents) do
    Enum.map(contents, fn l -> to_novel_list(l) end)
    |> Novex.Utils.List.one_dim_zip
    |> _init()
  end
  defp _init(contents) do
    {:ok, contents}
  end

  @doc """
    Print value and go to current value
  """
  def handle_call(:read, _from, []), do: sync_reply(nil, [])
  def handle_call(:read, _from, state) do
    Process.send_after(self(), :next, 100)
    sync_reply(:ok, state)
  end

  def handle_call(:fast_read, _from, []), do: sync_reply(nil, [])
  def handle_call(:fast_read, _from, state) do
    [until, rest] = Novex.Utils.List.until(state, "\n")
    IO.write(until)
    sync_reply(until, rest)
  end

  @doc """
    Schedule worker job
  """
  def handle_info(:next, []), do: async_reply([])
  def handle_info(:next, [head | tail]) do
    IO.write(head)
    novel_print()
    async_reply(tail)
  end

  defp sync_reply(val, next) do
    {:reply, val, next}
  end

  defp async_reply(next) do
    {:noreply, next}
  end

  defp novel_print do
    Process.send_after(self(), :next, 100)
  end

  defp to_novel_list(str), do: to_list(str) ++ ["\n"]
  defp to_list(str), do: Novex.Utils.String.to_list(str)
end
