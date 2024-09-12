defmodule BinaryHeap do
  def new(list) do
    list
    |> Enum.reduce(empty(), fn item, heap ->
      updated_size_heap = %{heap | size: heap.size + 1}
      Map.put(updated_size_heap, heap.size, item)
    end)
  end

  def empty, do: %{size: 0}

  def get_root(%{0 => node} = _heap), do: node

  def get_root(_), do: {:error, "The heap has no elements"}

  def get_last(%{size: size} = heap) when size > 0 do
    Map.get(heap, size - 1)
  end

  def get_last(%{size: size}) when size == 0, do: {:error, "The heap has no elements"}

  def get_left_child(heap, index) do
    child_index = get_left_child_index(index)
    Map.get(heap, child_index)
  end

  def get_right_child(heap, index) do
    child_index = get_right_child_index(index)
    Map.get(heap, child_index)
  end

  def get_parent(heap, index) do
    parent_index = get_parent_index(index)
    Map.get(heap, parent_index)
  end

  def insert(heap, node) do
    heap = push_last(heap, node)
    %{size: size} = heap
    tricke_up(heap, size - 1)
  end

  def delete(%{size: size} = heap) do
    deleted_node = get_root(heap)

    new_heap =
      heap
      |> swap(0, size - 1)
      |> Map.delete(size - 1)
      |> Map.put(:size, size - 1)
      |> tricke_down(0)

    {deleted_node, new_heap}
  end

  # Private functions

  defp tricke_down(heap, node_to_delete_index) do
    if has_greater_child(heap, node_to_delete_index) do
      larger_child_index = get_larger_child_index(heap, node_to_delete_index)

      heap
      |> swap(node_to_delete_index, larger_child_index)
      |> tricke_down(larger_child_index)
    else
      heap
    end
  end

  defp get_larger_child_index(heap, index) do
    right_child = get_right_child(heap, index)
    right_child_index = get_right_child_index(index)
    left_child = get_left_child(heap, index)
    left_child_index = get_left_child_index(index)

    cond do
      !right_child ->
        left_child_index

      right_child > left_child ->
        right_child_index

      left_child >= right_child ->
        left_child_index

      true ->
        :error
    end
  end

  defp has_greater_child(heap, index) do
    parent = Map.get(heap, index)
    left_child = get_left_child(heap, index)
    right_child = get_right_child(heap, index)

    (left_child && left_child > parent) ||
      (right_child && right_child > parent)
  end

  defp tricke_up(heap, new_node_index) do
    parent_index = get_parent_index(new_node_index)

    if new_node_index == 0 ||
         Map.get(heap, new_node_index) < Map.get(heap, parent_index) do
      heap
    else
      new_heap = swap(heap, parent_index, new_node_index)
      tricke_up(new_heap, parent_index)
    end
  end

  defp swap(heap, index1, index2) do
    node1 = Map.get(heap, index1)
    node2 = Map.get(heap, index2)

    heap
    |> Map.put(index1, node2)
    |> Map.put(index2, node1)
  end

  defp get_parent_index(child_index), do: div(child_index - 1, 2)

  defp get_left_child_index(parent_index), do: parent_index * 2 + 1

  defp get_right_child_index(parent_index), do: parent_index * 2 + 2

  defp push_last(%{size: size} = heap, node) do
    updated_size_heap = %{heap | size: size + 1}
    Map.put(updated_size_heap, size, node)
  end
end
