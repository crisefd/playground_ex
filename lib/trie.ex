defmodule Trie do
  def autocomplete(trie, prefix) do
    current_node = search(trie, prefix)

    if !current_node do
      nil
    else
      collect_all_words(current_node)
    end
  end

  def search(trie, word) do
    word
    |> Enum.reduce_while(trie, fn char, current_node ->
      child_node = Map.get(current_node, char)
      if child_node, do: {:cont, child_node}, else: {:halt, nil}
    end)
  end

  def insert(trie, word, popularity \\ 0) do
    word
    |> Enum.reduce_while(trie, fn char, current_node ->
      child_node = Map.get(current_node, char)

      if is_terminal_node?(child_node) do
        new_node = %{nil => popularity}
        {:halt, Map.put(current_node, char, new_node)}
      else
        {:cont, child_node}
      end
    end)
  end

  def collect_all_words(node, word_list \\ [], word \\ []) do
    node
    |> Map.to_list()
    |> append_word(word_list, word)
  end

  # Private functions

  defp append_word(node_tuples, word_list, word)

  defp append_word([], word_list, _), do: word_list

  defp append_word([{nil, _} | items], word_list, word) do
    append_word(items, [word | word_list], word)
  end

  defp append_word([{char_key, child_node} | items], word_list, word) do
    new_word = [char_key | word]
    new_word_list = collect_all_words(child_node, word_list, new_word)
    append_word(items, new_word_list, word)
  end

  defp is_terminal_node?(nil), do: true

  defp is_terminal_node?(%{nil => _}), do: true

  defp is_terminal_node?(_), do: false
end
