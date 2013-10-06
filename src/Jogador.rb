# -*- encoding : utf-8 -*-

require_relative 'FilaDeAtaques'

class Jogador
  attr_reader :id, :nome
  attr_reader :cidades
  attr_reader :fila_de_ataques
  attr_accessor :tecnologia

  def initialize id, nome
    @id = id
    @nome = nome
    @tecnologia = 1
    @cidades = []
    @fila_de_ataques = FilaDeAtaques
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

  # @param [Local] local
  # @param [Tropa] tropa_atacante
  # @param [Tropa] tropa_defensora
  def adicionar_ataque local, tropa_atacante, tropa_defensora
    fila_de_ataques.adicionar local, tropa_atacante, tropa_defensora
  end

  # Método que deve ser executado ao final do turno deste jogador!
  def executar_ataques
    fila_de_ataques.executar_ataques
  end

end
