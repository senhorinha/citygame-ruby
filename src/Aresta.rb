class Aresta
  attr_accessor :peso
  attr_reader   :v

  def initialize v, peso = 1
    @v    = v
    @peso = peso
  end

end
