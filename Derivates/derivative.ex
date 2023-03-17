defmodule Derivative do
  @type literal() :: {:num, number()}
  |{:var, atom()}
  |{:sin, atom()}
  |{:cos, atom()}
  |{:pi , atom()}

  @type expr() :: {:add, expr(), expr()}
  |{:sub, expr(), expr()}
  |{:mul, expr(), expr()}
  |{:exp, expr(),expr()}
  |{:div , expr(), expr()}
  |{:q,{:num,literal()},{:num,literal()}}
  | literal()

  def test() do

    expression = {:add,
                      {:mul, {:num, 2}, {:var, :x}} ,
                      {:exp, {:var, :x}, {:num, 5}}}
    variable = :x
    d= deriv(expression, variable)
    IO.write("expression:  #{print(expression)}\n")
    IO.write("derivative:  #{print(d)}\n")
    IO.write("simplified:  #{print(simplify(d))}\n")


  end
    def test1() do

    expression = {:add,
                      {:mul, {:num, 2}, {:var, :x}} ,
                      {:mul, {:num, 2}, {:var, :x}}}
    variable = :x
    d= deriv(expression, variable)
    IO.write("expression:  #{print(expression)}\n")
    IO.write("derivative:  #{print(d)}\n")
    IO.write("simplified:  #{print(simplify(d))}\n")


  end

    def test2() do

    expression = {:sin, {:mul, {:num, 5}, {:var, :x}}}
    variable = :x
    d= deriv(expression, variable)
    IO.write("expression:  #{print(expression)}\n")
    IO.write("derivative:  #{print(d)}\n")
    IO.write("simplified:  #{print(simplify(d))}\n")


  end
      def test3() do

    expression = {:ln, {:var, :x}}
    variable = :x
    d= deriv(expression, variable)
    IO.write("expression:  #{print(expression)}\n")
    IO.write("derivative:  #{print(d)}\n")
    IO.write("simplified:  #{print(simplify(d))}\n")


  end

    def deriv({:num, _}, _) do
      {:num, 0}
    end
    def deriv({:sin, e1}, v) do
      {:mul, {:cos, e1}, deriv(e1, v)}
    end
    def deriv({:ln, e1}, _) do
      {:div, {:num, 1}, e1}
    end
    def deriv({:var, v}, v)
     do
      if v == v do
        {:num, 1}
           else
        {:num, 0}
      end

    end
    def deriv({:add, e1, e2}, v) do
      {:add, deriv(e1,v), deriv(e2,v)}
    end
    def deriv({:mul, e1, e2}, v) do
       {:add, {:mul, deriv(e1,v), e2} , {:mul, deriv(e2,v), e1}}

    end
   # def deriv({:exp, base, expo}, _) do # variable first then number
    #  {:mul, {:num, base}, {:exp, expo, {:sub, base, {:num, 1}}}}
    #end
    def deriv({:exp, base, {:num, exp}}, v) do
    {:mul, {:mul, {:num, exp}, {:exp, base,
     {:num, exp - 1}}}, deriv(base, v)}

     end

#    def deriv({:sqr, e1}, v) do # variable first then number
 #   {:mul, {:div,{:num, 1}, {:num, 2} , }}
  #end
   def derive({:sqrt, e}, v) do
    {:div, derive(e, v), {:mul, {:num, 2}, {:sqrt, e}}}
  end


  def simplify({:add, e1, e2}) do
    simplify_add(simplify(e1), simplify(e2))
  end
  def simplify({:sub, e1, e2}) do
    simplify_sub(simplify(e1), simplify(e2))
  end
  def simplify({:mul, e1, e2}) do
    simplify_mul(simplify(e1), simplify(e2))
  end
  def simplify({:div, e1, e2}) do
    simplify_div(simplify(e1), simplify(e2))
  end
  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1), simplify(e2))
  end
#  def simplify({:q, e1, e2}) do
#    simplify_q(simplify(e1), simplify(e2))
#  end
  def simplify({:ln, e}) do
    simplify_ln(simplify(e))
  end
  def simplify({:sqrt, e}) do
    simplify_sqrt(simplify(e))
  end


  def simplify(e) do e end



    def simplify_add({:num ,0},e2) do e2 end
    def simplify_add(e1,{:num,0}) do e1 end
    def simplify_add({:num,n1},{:num,n2}) do {:num,n1+n2} end
    def simplify_add({:q, n1, d1}, {:q, n2, d2}) do {:q, (n1*d2)+(n2*d1), d1*d2} end
    def simplify_add({:num, n1}, {:q, n2, d}) do {:q, (n1*d)+n2, d} end
    def simplify_add({:q, n2, d},{:num, n1}) do {:q, (n1*d) + n2, d} end
    def simplify_add(e1,e2) do {:add, e1, e2} end
    
    

    def simplify_mul({:num ,0},_) do {:num ,0} end
    def simplify_mul(_,{:num,0}) do {:num ,0} end
    def simplify_mul({:num ,1},e2) do e2 end
    def simplify_mul(e1 ,{:num ,1}) do e1 end
    def simplify_mul({:num,n1},{:num,n2}) do {:num ,n1*n2} end
    def simplify_mul({:q, n1, d1}, {:q, n2, d2}) do {:q, n1*n2, d1*d2} end
    def simplify_mul({:num, n1}, {:q, n2, d}) do {:q, n1*n2, d} end
    def simplify_mul(e1, e1) do {:exp, e1, {:num, 2}} end
    def simplify_mul(e1, e2) do {:mul,e1, e2} end
    

    def simplify_exp({:num ,0},_) do {:num ,1} end
    def simplify_exp(_,{:num,0}) do {:num ,1} end
    def simplify_exp(e1,{:num,1}) do e1 end
    def simplify_exp({:num,1}, e1) do e1 end
    def simplify_exp(e1, e2) do {:exp, e1, e2} end

    def simplify_sub({:num, n1},{:num, n2}) do {:num, n1-n2} end

    def simplify_div({:num, n1},{:num, n2}) do {:div, n1 / n2 } end
    def simplify_div({:var, v},{:num, n}) do {:div, {:var,v}, {:num, n} } end
    def simplify_div({:num, n},{:var, v}) do {:div, {:num,n}, {:var, v} } end
    def simplify_div(e1,{:num, 1}) do e1 end

    def simplify_div({:num, n1},{:num, n2}) do {:div, n1 / n2 } end
    def simplify_div({:var, v},{:num, n}) do {:div, {:var,v}, {:num, n} } end
    def simplify_div({:num, n},{:var, v}) do {:div, {:num,n}, {:var, v} } end
    def simplify_div(e1,{:num, 1}) do e1 end

    def simplify_ln({:num, 1}) do {:num, 0} end
    def simplify_ln(e) do e end

    def simplify_sqrt({:exp, e, {:num, 2}}) do e end
    def simplify_sqrt(e) do e end


  def print({:q, num}) do "#{print(num)}" end
  def print({:q, top, div}) do "#{print(top)}/#{print(div)}" end
  def print({:num, n}) do "#{n}" end
  def print({:var, v}) do "#{v}" end
  def print({:add, e1, e2}) do "(#{print(e1)} + #{print(e2)})" end
  def print({:sub, e1, e2}) do "(#{print(e1)} - #{print(e2)})" end
  def print({:mul, e1, e2}) do "#{print(e1)} * #{print(e2)}" end
  def print({:div, top, div}) do "(#{print(top)}) / (#{print(div)})" end
  def print({:exp, base, exp}) do "(#{print(base)}) ^ (#{print(exp)})" end
  def print({:ln, e}) do "ln(#{print(e)})" end
  def print({:sqrt, e}) do "sqrt(#{print(e)})" end
  def print({:sin, e}) do "sin(#{print(e)})" end
  def print({:cos, e}) do "cos(#{print(e)})" end
 



end
