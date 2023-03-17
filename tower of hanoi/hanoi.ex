defmodule Hanoi do
    def test1() do
     solve(3,A,B,C);
    end
    def test2() do
     solve(4,A,B,C);
    end

    def test3() do
        solve(5,A,B,C);
    end

    def solve(n, from, to, aux) when n > 0 do
        solve(n-1, from, to, aux) 
    
     IO.puts("{:move, #{from}, #{to}}") 
    
     solve(n-1, aux, from, to)
  end

    def solve(0, _, _, _) do nil end
end