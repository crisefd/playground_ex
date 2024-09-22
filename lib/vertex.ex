defmodule Vertex do
  defstruct value: nil,
            id: nil,
            neighbours: MapSet.new([])

  def new(value) do
    %Vertex{value: value, id: Base.encode16(:crypto.strong_rand_bytes(64))}
  end

  def add_neighbour(
        %Vertex{neighbours: neighbours} = vertex,
        neighbour
      ) do
    if already_a_neighbour?(neighbours, neighbour) do
      vertex
    else
      %{
        vertex
        | neighbours: MapSet.put(neighbours, neighbour.id)
      }
    end
  end

  # Private functions

  defp already_a_neighbour?(neighbours, vertex) do
    MapSet.member?(neighbours, vertex.id)
  end
end
