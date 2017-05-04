defmodule Terminal do
  use GenServer

  def start_link(output_pid) do
    GenServer.start_link(__MODULE__, output_pid)
  end

  def init(output_pid) do
    {:ok, shell, _} = :exec.run('$SHELL', [:stdin, :stdout, :stderr, :pty])

    :exec.send(shell, "stty echo\r")

    {:ok, %{
      output_pid: output_pid,
      shell: shell
      }
    }
  end
  def send_input(terminal, input) do
    GenServer.cast(terminal, {:input, input})
  end

  def handle_cast({:input, input}, %{shell: shell} = state) do
    IO.puts "Input #{input}"
    IO.puts Process.alive?(shell)
    :exec.send(shell, input)
    {:noreply, state}
  end

  def handle_info({:stdout, _ref, output}, %{output_pid: output_pid} = state) do
    IO.puts "output #{output}"
    send(output_pid, {:output, output})
    {:noreply, state}
  end
end
