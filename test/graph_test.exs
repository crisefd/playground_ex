defmodule GraphTest do
  use ExUnit.Case

  test "Depth-First Search" do
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

    graph = %{
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

    # assert Graph.search(:dfs, graph, alice.id, "Irena").id == irena.id
    # assert Graph.search(:dfs, graph, alice.id, "Helen").id == helen.id
    assert Graph.search(:dfs, graph, alice.id, "Fred").id == fred.id
  end
end
