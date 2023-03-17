defmodule EnvTree do
## {:node, key, value, left, right}
##{:node, key, value, {:node, key, value, left, right}, right}
## add function
# bigger to right, smaller to left
    def new() do
        nil   
    end

    def add(key, value, :nil) do
       {:node, key, value, :nil, :nil} 
    end

     def add(key, value, {:node, k, v, left, right}) do
         if key < k do
            {:node, k, v, add(key,value,left), right}
        else
            {:node, k, v, left, add(key,value,right)}
        end
    end     

##modify functions
    def modify(_,_,:nil) do :nil end
    def modify(key, value, {:node, key, _, left, right}) do
    {:node, key, value, left, right} 
     end
    def modify(key, value, {:node, k, v, left, right}) do
    if key < k do
        {:node, k, v, modify(key, value,left) , right} 
            else
        {:node, k, v, left, modify(key, value,right)}
        end
    end
    #look up function
    def lookup(key,{:node, key, value, _, _}) do
        {:value, value}
    end
    def lookup(key,{:node, k, _, left, right}) do
        if key < k  do
        lookup(key,left)
        else
        lookup(key,right)
        end
    end
    def lookup(_,_) do :"Non existing element" end

    ## delet function
    def remove(nil, _) do
        nil
    end
    def remove({:node, key,_, :nil, :nil},key) do
        :nil
    end
    def remove({:node, key,_, left, :ni},key) do
        left
    end
    def remove({:node, key,_, :nil, right},key) do
        right
    end

    def remove({:node, key, _, left, right}, key) do
        {key, value, rest} = leftmost(right)
        {:node, key, value, left, rest}
  end

    def remove({:node, k, v, left, right},key) do
        if key < k  do
        {:node,k,v, remove(left,key), right}
        else
        {:node,k,v,left, remove(right,key)}
        end
    end


    def leftmost({:node, key, value, nil, nil}) do
    #IO.puts(key,value)
    remove({:node, key, value, :nil, :nil},key)
    end

    def leftmost({:node,key,value,nil,right}) do
        {key, value, right}
    end

    def leftmost({:node, k, v, left, right}) do
        {key,value,rest} = leftmost(left)
        {key,value,{:node,k, v, rest, right}}
    end


  #  def remove(_,_) do :"No existing node" end


end






