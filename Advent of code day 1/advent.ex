defmodule Advent do
  def getCalories() do
    {:ok, calories} = File.read("calories.txt")
    calories = String.split(calories, "\r\n\r\n")

    calories|> Enum.map(fn cal -> 
      cal
      |> String.split("\r\n")
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
  end 

  def findBiggest(n) do
    calories = getCalories()
    calories = Enum.sort(calories, :desc)
    Enum.sum(Enum.take(calories, n))
  end
end