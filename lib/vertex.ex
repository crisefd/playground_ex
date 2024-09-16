defmodule Vertex do
  defstruct value: nil,
            id: Base.encode16(:crypto.strong_rand_bytes(64)),
            neighbours: MapSet.new([]),
            neighbour_list: []

  def new(value), do: %Vertex{value: value}

  # def associate(vertex1, vertex2) do
  #   new_vertex1 = add_neighbour(vertex1, vertex2)
  #   new_vertex2 = add_neighbour(vertex2, vertex1)
  #   {new_vertex1, new_vertex2}
  # end
  #
  # def add_neighbours(vertex, neighbour_list) do
  #   neighbour_list
  #   |> Enum.reduce(vertex, fn neighbour, updated_vertex ->
  #     add_neighbour(updated_vertex, neighbour)
  #   end)
  # end

  def add_neighbour(
        %Vertex{neighbours: neighbours, neighbour_list: neighbour_list} = vertex,
        neighbour
      ) do
    if already_a_neighbour?(neighbours, neighbour) do
      vertex
    else
      %{
        vertex
        | neighbours: Map.put(neighbours, neighbour.id, neighbour),
          neighbour_list: [neighbour.id | neighbour_list]
      }
    end
  end

  # Private functions

  defp already_a_neighbour?(neighbours, vertex) do
    MapSet.member?(neighbours, vertex.id)
  end
end
