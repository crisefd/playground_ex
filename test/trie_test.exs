defmodule TrieTest do
  use ExUnit.Case

  @trie %{
    ?a => %{
      ?c => %{?e => %{nil => 0}, ?t => %{nil => 0}}
    },
    ?b => %{
      ?a => %{
        ?d => %{nil => 0},
        ?k => %{?e => %{nil => 0}},
        ?t => %{nil => 0, ?t => %{?e => %{?r => %{nil => 0}}}}
      }
    },
    ?c => %{
      ?a => %{
        ?b => %{nil => 0},
        ?t => %{nil => 0, ?n => %{?a => %{?p => %{nil => 0}}, ?i => %{?p => %{nil => 0}}}}
      }
    }
  }

  test "Search word in the trie" do
    word = ~c"cat"

    result = Trie.search(@trie, word)
    expected = %{nil => 0, ?n => %{?a => %{?p => %{nil => 0}}, ?i => %{?p => %{nil => 0}}}}

    assert result == expected
  end

  test "Insert word into the trie" do
    word = ~c"can"

    result = Trie.insert(@trie, word)

    expected = %{
      ?n => %{nil => 0},
      ?b => %{nil => 0},
      ?t => %{nil => 0, ?n => %{?a => %{?p => %{nil => 0}}, ?i => %{?p => %{nil => 0}}}}
    }

    assert result == expected
  end

  test "Collecting all words in the trie" do
    result = Trie.collect_all_words(@trie)

    expected =
      [
        ~c"tac",
        ~c"pintac",
        ~c"pantac",
        ~c"bac",
        ~c"tab",
        ~c"rettab",
        ~c"ekab",
        ~c"dab",
        ~c"tca",
        ~c"eca"
      ]

    assert result == expected
  end
end
