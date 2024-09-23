defmodule Queue do
  def new() do
    :queue.new()
  end

  def push(queue, item) do
    :queue.in(item, queue)
  end

  def pop({[], []} = queue), do: {nil, queue}

  def pop(queue) do
    {{:value, value}, new_queue} = :queue.out(queue)
    {value, new_queue}
  end

  def to_list(queue) do
    [a, b] = Tuple.to_list(queue)
    a ++ b
  end
end
