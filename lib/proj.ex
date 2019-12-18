defmodule BaseSupervisor do
  use Supervisor
  def start_link(min, max) do
    Supervisor.start_link(__MODULE__,[min, max])
	end
  def init([min, max]) do

  n3 = trunc(div(max-min,1000))
    children = Enum.map(1..1000, fn(x)->
      n1= min+(x-1)*n3
      n2 = min+x*n3
      worker(Genmodule,[n1,n2],[id: x, restart: :transient])
		end)
		    supervise(children,strategy: :one_for_one)
  end
end

defmodule Proj do

	def func(args \\ []) do
    options = [switches: [file: :string],aliases: [f: :file]]
      {_,ar2,_} = OptionParser.parse(args,options)

    min = String.to_integer(List.first(ar2))
    max = String.to_integer(List.last(ar2))
		ids = BaseSupervisor.start_link(min,max)
		child_id = Supervisor.which_children(elem(ids,1))
		list = Enum.map(child_id,fn(x)->
			Genmodule.get_vamp_fangs(elem(x,1))
		end)
    li = List.flatten(list)|>Enum.uniq()
    li = li--[[]]
    li = Enum.sort(li)
    Enum.each(li,fn(x)-> IO.puts x end)
  end
end


defmodule Genmodule do

  use GenServer
  def start_link(n1,n2) do
    GenServer.start_link(__MODULE__,[n1,n2])
  end

  def init([n1,n2]) do
    GenServer.cast(self(),{:get_range,n1,n2})
    {:ok,"ok"}
  end

  def get_vamp_fangs(pid) do
		GenServer.call(pid,:gen_vamp_fangs)
	end

	def handle_call(:gen_vamp_fangs, _from, state) do
        {:reply, state, state}
	end

  def handle_cast({:get_range, n1,n2}, _) do
		{:ok,state} = range(n1,n2)

        {:noreply, state}
  end

  def range(n1,n2) do
    li =Enum.map(n1..n2,fn(x)->is_vampire(x) end)|>Enum.uniq()
    li = li--[nil]
    {:ok,li}
  end

def is_vampire(x) do
  t = fangs(x)
  if length(t) !=0 do
  s = Enum.map(t,fn(x)->Tuple.to_list(x) end) |> List.flatten()
s = Enum.join(s," ")
  Integer.to_string(x)<>" "<>s
 end
end


def comp(n) do
    n1 = trunc(n / :math.pow(10, div(size(n), 2)))
    n2  = :math.sqrt(n) |> round
    for i <- n1 .. n2, rem(n,i) == 0, do: {i,div(n,i)}
  end

  defp size(n), do: length(to_charlist(n))

  def fangs(n) do
    if rem(size(n), 2) == 1 do
      []
    else
      k = div(length(to_charlist(n)), 2)
      sorted = Enum.sort(String.codepoints("#{n}"))
      Enum.filter(comp(n), fn {i, j} -> size(i) == k && size(j) == k &&
        Enum.count([i, j], fn x -> rem(x, 10) == 0 end) != 2 &&
        Enum.sort(String.codepoints("#{i}#{j}")) == sorted
      end)
    end
  end
end
Proj.func(System.argv)
