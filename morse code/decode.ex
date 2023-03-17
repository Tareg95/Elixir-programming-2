defmodule Decode do
   def test() do
    code =String.split(".- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ... ", " ")
    tree = Morse.morse();
    List.delete(decode(code, tree), :na)
  end
  def test1() do
    code =String.split(".... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .----", " ")
    tree = Morse.morse();
    List.delete(decode(code, tree), :na)
  end
  def decode([], _) do [] end
  def decode([head | tail], tree) do
    [decoder(head, tree) | decode(tail, tree)]
  end

  def decoder(code, {:node, character, left, right}) do
  first_character = String.at(code, 0)
  case first_character do
  "." -> decoder(String.slice(code, 1..-1), right)
  "-" -> decoder(String.slice(code, 1..-1), left)
  _ -> character
  end
end




end