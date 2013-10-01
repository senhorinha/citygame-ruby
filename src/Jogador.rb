class Jogador
  attr_reader :id, :nome
  attr_reader :cidades
  attr_accessor :tecnologia

  def initialize id, nome
    @id   = id
    @nome = nome
    @tecnologia = 1
    @cidades = []
  end

  def gerar_recursos
    tec = 0
    @cidades.each do |cidade|
      cidade.gerar_exercitos()
      tec += cidade.taxa_tecnologia()
    end
    tec /= 100
    @tecnologia = tecnologia*(1 + tec)
  end

end
