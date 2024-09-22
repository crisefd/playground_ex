defmodule Graph do
  def search(type, graph, initial_vertex_id, target, target_by \\ :value)

  def search(:dfs, graph, initial_vertex_id, target, target_by) do
    initial_vertex = Map.get(graph, initial_vertex_id)
    dfs(graph, initial_vertex, MapSet.new(), target, target_by)
  end

  # def search(:bfs, graph, initial_vertex_id, target, target_by) do
  #   initial_vertex = Map.get(graph, initial_vertex_id)
  #   bfs(graph, initial_vertex, MapSet.new(), target, target_by, Queue.new())
  # end

  def search(type, _, _, _, _), do: {:error, "Invalid search type #{type}"}

  # private functions

  # defp bfs(
  #        graph,
  #        %Vertex{id: id, value: value} = vertex,
  #        visited,
  #        target,
  #        target_by,
  #        queue
  #      ) do
  #   IO.inspect(value, label: "visiting vertex #{id}")
  #
  #   new_visited = MapSet.put(visited, id)
  #   new_queue = Queue.push(queue, vertex)
  #
  #   bfs_visit(graph, new_visited, target, target_by, new_queue)
  # end
  #
  # defp bfs_visit(_graph, _visited, _target, _target_by, {[], []}), do: nil
  #
  # defp bfs_visit(graph, visited, target, target_by, queue) do
  #   {current_vertex, popped_queue} = Queue.pop(queue)
  #   %Vertex{neighbour_list: neighbour_list} = current_vertex
  #
  #   if target_found?(current_vertex, target, target_by) do
  #     current_vertex
  #   else
  #     {updated_visited, updated_queue} =
  #       Enum.reduce(neighbour_list, {visited, popped_queue}, fn neighbour,
  #                                                               {new_visited, new_queue} ->
  #         if visited?(new_visited, neighbour) do
  #           {new_visited, new_queue}
  #         else
  #           {MapSet.put(new_visited, neighbour), Queue.push(new_queue, Map.get(graph, neighbour))}
  #         end
  #       end)
  #
  #     bfs_visit(graph, updated_visited, target, target_by, updated_queue)
  #   end
  # end

  defp dfs(
         graph,
         %Vertex{id: id, neighbours: neighbours, value: value} =
           vertex,
         visited,
         target,
         target_by
       ) do
    IO.inspect(value, label: "visiting vertex #{id}")
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
