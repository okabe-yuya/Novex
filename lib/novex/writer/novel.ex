defmodule Novex.Writer.Novel do
  @moduledoc """
    tmp
  """

  use GenServer

  @doc """
    Launch GenServer no stack or set stack
  """
  def init do
    set_settings()
    _init([])
  end
  def init(content) when is_binary(content) do
    set_settings()
    [to_novel_list(content)] |> _init()
  end
  def init(contents) when is_list(contents) do
    set_settings()
    Enum.map(contents, fn l -> to_novel_list(l) end) |> _init()
  end
  defp _init(contents) do
    {:ok, contents}
  end
  defp set_settings do
    settings = Novex.Settings.load_settings()
    Process.put(:settings, settings)
  end

  @doc """
    Print value and go to current value
  """
  def handle_cast(:read, []), do: async_reply([])
  def handle_cast(:read, state) do
    Process.send_after(self(), :next, 100)
    async_reply(state)
  end

  def handle_cast(:fast_read, []), do: async_reply([])
  def handle_cast(:fast_read, [head | tail]) do
    write_wrapper(head)
    async_reply(tail)
  end

  def handle_cast(:all_read, []), do: async_reply([])
  def handle_cast(:all_read, state) do
    rest_time = rest_time()
    Enum.each(state, fn lst ->
      Enum.each(lst, fn l ->
        :timer.sleep(rest_time)
        write_wrapper(l)
      end)
    end)
    async_reply([])
  end

  def handle_cast({:print, content}, state) do
    rest_time = rest_time()
    to_novel_list(content) |> Enum.each(fn c ->
      :timer.sleep(rest_time)
      write_wrapper(c)
    end)
    async_reply(state)
  end

  @doc """
    Schedule worker job
  """
  def handle_info(:next, []), do: async_reply([])
  def handle_info(:next, [[] | tail]), do: async_reply(tail)
  def handle_info(:next, [[h | t] | tail]) do
    write_wrapper(h)
    novel_print()
    async_reply([t | tail])
  end

  defp write_wrapper(h) do
    settings = Process.get(:settings)
    _write_wrapper(h, h in settings[:punctuation], settings)
  end
  defp _write_wrapper(h, false, _), do: IO.write(h)
  defp _write_wrapper(h, _, settings) do
    IO.write(h)
    rest_time(settings) * 2 |> :timer.sleep()
  end

  defp novel_print, do: Process.send_after(self(), :next, rest_time())

  # load value from settings
  defp end_string(settings), do: settings[:end_string] || Novex.Settings.Default.end_string()
  defp end_string, do: Process.get(:settings) |> end_string()
  defp rest_time(settings), do: settings[:rest_time] || Novex.Settings.Default.rest_time()
  defp rest_time, do: Process.get(:settings) |> rest_time()

  # response tuple
  defp async_reply(next), do: {:noreply, next}

  # convert string to list
  defp to_novel_list(str), do: to_list(str) ++ [end_string(), "\n"]
  defp to_list(str), do: Novex.Utils.String.to_list(str)
end
