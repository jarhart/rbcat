class ST

  class << self

    def [](x)
      new { |s| [x, s] }
    end

    def get
      @get ||= new { |s| [s, s] }
    end

    def set(s)
      new { [nil, s] }
    end

    def update(&f)
      get >>-> s { set(f.(s)) }
    end

    def sequence(sts)
      new { |s0|
        sts.inject([[], s0]) { |(xs, s), st| st.map { |x| xs << x }.(s) }
      }
    end

    def chain(sts)
      sequence(sts).map { |xs| xs.last }
    end

    def repeat(n, st)
      new { |s0| n.times.inject([nil, s0]) { |(x, s),| st.(s) } }
    end
  end

  def initialize(&f)
    @f = f
  end

  def call(s)
    @f.(s)
  end

  def >>(g)
    ST.new { |s|
      x, s2 = self.(s)
      g.(x).(s2)
    }
  end

  def map(&g)
    self >>-> x { ST[g.(x)] }
  end

  def &(other)
    ST.chain([self, other])
  end
end
