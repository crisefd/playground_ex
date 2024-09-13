defmodule Graph do
  def search(type, graph, target, target_by \\ :value)

  def search(:dst, graph, target, target_by) do
    dfs(graph, MapSet.new(), target, target_by)
  end

  def search(:bfs, graph, target, target_by) do
    bfs(graph, MapSet.new(), target, target_by, Queue.new())
  end

  def search(type, _, _, _), do: {:error, "Invalid search type #{type}"}

  # private functions

  defp bfs(
         %Vertex{id: id, value: value} = vertex,
         visited,
         target,
         target_by,
         queue
       ) do
    IO.inspect(value, label: "visiting vertex #{id}")

    new_visited = MapSet.put(visited, id)
    new_queue = Queue.push(queue, vertex)

    bfs_visit(new_visited, target, target_by, new_queue)
  end

  defp bfs_visit(_visited, _target, _target_by, {[], []}), do: nil

  defp bfs_visit(visited, target, target_by, queue) do
    {current_vertex, popped_queue} = Queue.pop(queue)
    %Vertex{neighbours: neighbour_list} = current_vertex

    if target_found?(current_vertex, target, target_by) do
      current_vertex
    else
      {updated_visited, updated_queue} =
        Enum.reduce(neighbour_list, {visited, popped_queue}, fn neighbour,
                                                                {new_visited, new_queue} ->
          if visited?(new_visited, neighbour.id) do
            {new_visited, new_queue}
          else
            {MapSet.put(new_visited, neighbour.id), Queue.push(new_queue, neighbour)}
          end
        end)

      bfs_visit(updated_visited, target, target_by, updated_queue)
    end
  end

  defp dfs(vertex, visited, target, target_by)

  defp dfs(
         %Vertex{id: id, neighbours: neighbours, value: value} = vertex,
         visited,
         target,
         target_by
       ) do
    IO.inspect(value, label: "visiting vertex #{id}")
    new_visited = MapSet.put(visited, id)

    cond do
      target_found?(vertex, target, target_by) ->
        vertex

      Enum.empty?(neighbours) ->
        nil

      true ->
        dfs_visit(neighbours, new_visited, target, target_by)
    end
  end

  defp dfs_visit([vertex | vertices], visited, target, target_by) do
    if visited?(visited, vertex.id) do
      dfs_visit(vertices, visited, target, target_by)
    else
      dfs(vertex, visited, target, target_by)
    end
  end

  defp target_found?(vertex, target, target_by) do
    Map.get(vertex, target_by, target)
  end

  defp visited?(visited, vertex_id), do: MapSet.member?(visited, vertex_id)
end
