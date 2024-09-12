defmodule BinaryHeapTest do
  use ExUnit.Case
  alias BinaryHeap, as: Heap

  test "Creation of new heap from list" do
    result = Heap.new([100, 88, 25, 87, 16, 8, 12, 86, 50, 2, 15, 3])

    expected = %{
      0 => 100,
      1 => 88,
      2 => 25,
      3 => 87,
      4 => 16,
      5 => 8,
      6 => 12,
      7 => 86,
      8 => 50,
      9 => 2,
      10 => 15,
      11 => 3,
      size: 12
    }

    assert expected == result
  end

  test "Getting the root node" do
    heap1 = Heap.new([100, 88, 25, 87, 16, 8, 12, 86, 50, 2, 15, 3])
    result1 = Heap.get_root(heap1)

    assert result1 == 100

    heap2 = Heap.empty()

    result2 = Heap.get_root(heap2)

    assert {:error, _} = result2
  end

  test "Getting the last node" do
    heap1 = Heap.new([100, 88, 25, 87, 16, 8, 12, 86, 50, 2, 15, 3])
    result1 = Heap.get_last(heap1)

    assert result1 == 3

    heap2 = Heap.empty()

    result2 = Heap.get_last(heap2)

    assert {:error, _} = result2
  end

  test "Getting children" do
    heap = Heap.new([100, 88, 25, 87, 16, 8, 12, 86, 50, 2, 15, 3])
    index = 4
    left_child1 = Heap.get_left_child(heap, index)
    right_child1 = Heap.get_right_child(heap, index)

    assert left_child1 == 2
    assert right_child1 == 15

    index = 11

    left_child2 = Heap.get_left_child(heap, index)
    right_child2 = Heap.get_right_child(heap, index)

    assert left_child2 == nil
    assert right_child2 == nil

    index = 5

    left_child3 = Heap.get_left_child(heap, index)
    right_child3 = Heap.get_right_child(heap, index)

    assert left_child3 == 3
    assert right_child3 == nil
  end

  test "Inserting into the heap" do
    heap = Heap.new([100, 88, 25, 87, 16, 8, 12, 86, 50, 2, 15, 3])

    result = Heap.insert(heap, 40)

    expected = Heap.new([100, 88, 40, 87, 16, 25, 12, 86, 50, 2, 15, 3, 8])

    assert result == expected
  end

  test "Deleting from the heap" do
    heap = Heap.new([100, 88, 25, 87, 16, 8, 12, 86, 50, 2, 15, 3])

    {deleted_node, new_heap} = Heap.delete(heap)

    expected_deleted_node = 100

    expected_new_heap = Heap.new([88, 87, 25, 86, 16, 8, 12, 3, 50, 2, 15])

    assert deleted_node == expected_deleted_node
    assert new_heap == expected_new_heap
  end
end
