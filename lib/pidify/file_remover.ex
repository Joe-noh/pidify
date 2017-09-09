defmodule Pdfy.FileRemover do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def remove_after(path, milliseconds) do
    GenServer.cast(__MODULE__, {:remove, %{path: path, after: milliseconds}})
  end

  def handle_cast({:remove, %{path: path, after: milliseconds}}, state) do
    Process.send_after(self(), {:remove, path}, milliseconds)

    {:noreply, state}
  end

  def handle_info({:remove, path}, state) do
    File.rm(path)

    {:noreply, state}
  end
end
