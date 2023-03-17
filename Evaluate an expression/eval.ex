defmodule Eval do 
   def test1() do ## a= 3, c=2, x=5, y=7, z= 10, expression= 4+5x
   expression = {:add, {:num, 4}, {:mul, {:num, 5}, {:var, :x}}}
   tree = {:node, :x, 5,
   {:node, :c, 2,{:node, :a, 3, nil, nil}, nil}, 
   {:node, :y, 7, nil, {:node, :z, 10, nil, nil}}}

   Derivative.print(eval(expression, tree))
   end

      def test2() do
   expression = {:add, {:num, 4}, {:mul, {:num, 5}, {:var, :z}}}
   tree = {:node, :x, 5,
   {:node, :c, 2,{:node, :a, 3, nil, nil}, nil}, 
   {:node, :y, 7, nil, {:node, :z, 10, nil, nil}}}

   Derivative.print(eval(expression, tree))
   end

   def test3() do
   expression = {:add, {:num, 4}, {:mul, {:num, 5}, {:var, :a}}}
   tree = {:node, :x, 5,
   {:node, :c, 2,{:node, :a, 3, nil, nil}, nil}, 
   {:node, :y, 7, nil, {:node, :z, 10, nil, nil}}}

   Derivative.print(eval(expression, tree))
   end
   def test4() do
   expression = {:sub, {:mul, {:num, 5}, {:var, :a}}, {:num, 4}}
   tree = {:node, :x, 5,
   {:node, :c, 2,{:node, :a, 3, nil, nil}, nil}, 
   {:node, :y, 7, nil, {:node, :z, 10, nil, nil}}}

   Derivative.print(eval(expression, tree))
   end

   def test5() do
      expression = {:add, {:mul, {:num, 5}, {:var, :a}}, {:q, {:num, 4},{:num,2}}}
      tree = {:node, :x, 5,
      {:node, :c, 2,{:node, :a, 3, nil, nil}, nil}, 
      {:node, :y, 7, nil, {:node, :z, 10, nil, nil}}}

   Derivative.print(eval(expression, tree))
   end
   def test6() do
      expression = {:mul, {:var, :x} , {:q, {:num, 1}, {:num, 2}}}
      tree = {:node, :x, 5,
      {:node, :c, 2,{:node, :a, 3, nil, nil}, nil}, 
      {:node, :y, 7, nil, {:node, :z, 10, nil, nil}}}

   Derivative.print(eval(expression, tree))
   end

    def eval({:num, n }, _) do {:num, n} end
    def eval({:q,{:num, n1}, {:num, n2}}, _) do {:q,{:num, n1}, {:num, n2}} end
    def eval({:var, x}, tree) do 

        {:value, num} = EnvTree.lookup(x,tree)
        {:num,num}
    end



    def eval({:add, key1, key2}, tree) do

       Derivative.simplify({:add,eval(key1, tree),eval(key2, tree)})
        

    end
    def eval({:sub, key1, key2}, tree) do

       Derivative.simplify({:sub,eval(key1, tree),eval(key2, tree)})

      
    end

    def eval({:mul, key1, key2}, tree) do

       Derivative.simplify({:mul,eval(key1, tree),eval(key2, tree)})
        

    end
    def eval({:div, key1, key2}, tree) do

       Derivative.simplify({:div,eval(key1, tree),eval(key2, tree)})

      
    end
   # def eval({:q, key1, key2}, tree) do
      
    #   Derivative.simplify({:q,d(eval(key1, tree),eval(key2, tree))})

    #end
    def d({:num, n1}, {:num, n2}) do
      if rem(n1, n2) == 0 do
         {:num, trunc(n1/n2)}
    else
      reduce(n1, n2)
    end
  end

  def gcd(n, 0) do n end
  def gcd(n1, n2) do gcd(n2, rem(n1, n2)) end

  def reduce(e1, e2) do
    {:q, trunc(e1/gcd(e1,e2)), trunc(e2/gcd(e1,e2))}
  end

    
    
    
end


