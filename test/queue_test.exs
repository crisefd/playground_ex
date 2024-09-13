defmodule QueueTest do
  use ExUnit.Case

  test "Pushing into the queue" do
    queue =
      Queue.new()
      |> Queue.push(5)
      |> Queue.push(50)
      |> Queue.push(500)

    expected = {[500, 50], [5]}

    assert queue == expected
  end

  test "Popping the queue" do
    initial_queue = {[500, 50], [5]}

    expected_popped_queue1 = {[500], [50]}

    {popped_value1, popped_queue1} = Queue.pop(initial_queue)

    assert popped_value1 == 5
    assert popped_queue1 == expected_popped_queue1

    expected_popped_queue2 = {[], [500]}

    {popped_value2, popped_queue2} = Queue.pop(popped_queue1)

    assert popped_value2 == 50
    assert popped_queue2 == expected_popped_queue2

    expected_popped_queue3 = {[], []}

    {popped_value3, popped_queue3} = Queue.pop(popped_queue2)

    assert popped_value3 == 500
    assert popped_queue3 == expected_popped_queue3

    expected_popped_queue4 = {[], []}

    {popped_value4, popped_queue4} = Queue.pop(popped_queue3)

    assert popped_value4 == nil
    assert popped_queue4 == expected_popped_queue4
  end
end
