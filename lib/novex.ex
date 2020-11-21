defmodule Novex do
  @moduledoc """
  Documentation for `Novex`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Novex.hello()
      :world

  """
  def hello do
    :world
  end

  def launcher do
    sample = Novex.Sample.wagahai_ha_neko_de_aru()
    {:ok, pid} = GenServer.start_link(Novex.Writer.Novel, sample)
    pid
  end

  def print_validater do
    pid = launcher()
    GenServer.call(pid, :read)
  end

  def fast_print_validater do
    pid = launcher()
    GenServer.call(pid, :fast_read)
  end

  def mix_read_and_fast do
    pid = launcher()
    GenServer.call(pid, :read)
    :timer.sleep(2000)
    GenServer.call(pid, :fast_read)
    :timer.sleep(3000)
    GenServer.call(pid, :fast_read)
  end
end
