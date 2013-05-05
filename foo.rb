class Proc

  def map(&f)
    -> x { f.(self.(x)) }
  end

  def bind(&f)
    -> x { f.(self.(x)).(x) }
  end
end
