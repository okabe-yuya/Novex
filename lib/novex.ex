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
    GenServer.cast(pid, :read)
  end

  def fast_print_validater do
    pid = launcher()
    GenServer.cast(pid, :read)
    :timer.sleep(500)
    GenServer.cast(pid, :fast_read)
  end

  def mix_read_and_fast do
    pid = launcher()
    GenServer.cast(pid, :read)
    :timer.sleep(2000)
    GenServer.cast(pid, :fast_read)
    :timer.sleep(3000)
    GenServer.cast(pid, :fast_read)
  end

  def print do
    s = "In practice, it is common to have both server and client functions in the same module."
    pid = launcher()
    GenServer.cast(pid, {:print, s})
  end

  def all_read do
    pid = launcher()
    GenServer.cast(pid, :all_read)
    GenServer.cast(pid, :read)
  end
end
