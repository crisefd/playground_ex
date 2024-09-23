defmodule Graph do
  def search(type, graph, initial_vertex_id, target, target_by \\ :value)

  def search(:dfs, graph, initial_vertex_id, target, target_by) do
    initial_vertex = Map.get(graph, initial_vertex_id)
    dfs(graph, initial_vertex, MapSet.new(), target, target_by)
  end

  def search(:bfs, graph, initial_vertex_id, target, target_by) do
    initial_vertex = Map.get(graph, initial_vertex_id)
    queue = Queue.new() |> Queue.push(initial_vertex)
    bfs(graph, MapSet.new(), target, target_by, queue)
  end

  def search(type, _, _, _, _), do: {:error, "Invalid search type #{type}"}

  # private functions

  defp bfs(
         graph,
         visited,
         target,
         target_by,
         queue
       ) do
    {current_vertex, popped_queue} = Queue.pop(queue)
    %Vertex{neighbours: neighbours, id: id, value: _value} = current_vertex
    # IO.inspect(value, label: "visiting vertex #{id}")
    new_visited = MapSet.put(visited, id)

    new_neighbours = MapSet.difference(neighbours, new_visited)

    if target_found?(current_vertex, target, target_by) do
      current_vertex
    else
      new_queue =
        new_neighbours
        |> Enum.reduce(
          popped_queue,
          fn neighbour_id, local_queue ->
            neighbour = Map.get(graph, neighbour_id)
            Queue.push(local_queue, neighbour)
          end
        )

      bfs(graph, new_visited, target, target_by, new_queue)
    end
  end

  defp dfs(
         graph,
         %Vertex{id: id, neighbours: neighbours, value: _value} =
           vertex,
         visited,
         target,
         target_by
       ) do
    # IO.inspect(value, label: "visiting vertex #{id}")
    new_visited = MapSet.put(visited, id)
    new_neighbors = MapSet.difference(neighbours, new_visited)

    if target_found?(vertex, target, target_by) do
      vertex
    else
      new_neighbors
      |> MapSet.to_list()
      |> Enum.reduce_while(nil, fn neighbour_id, _ ->
        new_vertex = Map.get(graph, neighbour_id)
        search_result = dfs(graph, new_vertex, new_visited, target, target_by)

        if search_result do
          {:halt, search_result}
        else
          {:cont, nil}
        end
      end)
    end
  end

  defp target_found?(vertex, target, target_by) do
    Map.get(vertex, target_by) == target
  end

  defp visited?(visited, vertex_id), do: MapSet.member?(visited, vertex_id)
end
