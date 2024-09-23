defmodule GraphTest do
  use ExUnit.Case

  setup_all do
    alice = Vertex.new("Alice")
    bob = Vertex.new("Bob")
    candy = Vertex.new("Candy")
    derek = Vertex.new("Derek")
    elaine = Vertex.new("Elaine")
    fred = Vertex.new("Fred")
    gina = Vertex.new("Gina")
    helen = Vertex.new("Helen")
    irena = Vertex.new("Irena")

    alice_neighbour_ids = [bob.id, candy.id, derek.id, elaine.id]

    alice = %{
      alice
      | neighbours: MapSet.new(alice_neighbour_ids)
    }

    bob_neighbour_ids = [alice.id, fred.id]

    bob = %{bob | neighbours: MapSet.new(bob_neighbour_ids)}

    candy_neighbour_ids = [alice.id, helen.id]

    candy = %{
      candy
      | neighbours: MapSet.new(candy_neighbour_ids)
    }

    derek_neighbour_ids = [alice.id, elaine.id, gina.id]

    derek = %{
      derek
      | neighbours: MapSet.new(derek_neighbour_ids)
    }

    elaine_neighbour_ids = [alice.id, derek.id]

    elaine = %{
      elaine
      | neighbours: MapSet.new(elaine_neighbour_ids)
    }

    fred_neighbour_ids = [bob.id, helen.id]

    fred = %{
      fred
      | neighbours: MapSet.new(fred_neighbour_ids)
    }

    gina_neighbour_ids = [derek.id, irena.id]

    gina = %{
      gina
      | neighbours: MapSet.new(gina_neighbour_ids)
    }

    helen_neighbour_ids = [fred.id, candy.id]

    helen = %{
      helen
      | neighbours: MapSet.new(helen_neighbour_ids)
    }

    irena_neighbour_ids = [gina.id]

    irena = %{
      irena
      | neighbours: MapSet.new(irena_neighbour_ids)
    }

    vertices_map = %{
      alice.id => alice,
      bob.id => bob,
      candy.id => candy,
      derek.id => derek,
      elaine.id => elaine,
      fred.id => fred,
      gina.id => gina,
      helen.id => helen,
      irena.id => irena
    }

    %{
      vertices_map: vertices_map,
      alice: alice,
      bob: bob,
      candy: candy,
      derek: derek,
      elaine: elaine,
      fred: fred,
      gina: gina,
      helen: helen,
      irena: irena
    }
  end

  test "Depth-First Search", context do
    %{vertices_map: vertices_map, alice: alice, fred: fred} = context
    result = Graph.search(:dfs, vertices_map, alice.id, "Fred")
    assert result.id == fred.id
  end

  test "Breadth-First Search", context do
    %{vertices_map: vertices_map, alice: alice, irena: irena} = context
    result = Graph.search(:bfs, vertices_map, alice.id, "Irena")
    assert result.id == irena.id
  end
end
