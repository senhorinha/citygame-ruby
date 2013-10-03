# -*- encoding : utf-8 -*-

class Local

  attr_reader :@tropas

  def initialize id
    @tropas = []
  end

  # @param [Jogador] jogador
  def local_disponivel? jogador
    #TODO: Pensar em estados?
    if @tropas[0].jogador.eql? tropa.jogador or @tropas[0].nil?
      true
    elsif @tropas[1].jogador.eql? tropa.jogador or @tropas[1].nil?
      true
    end
    false
  end

  # @param [Tropa] tropa
  # @return [TrueClass]
  # @return [FalseClass]
  def ocupa tropa
    #TODO: Resolver esse monte de ifs
    if local_disponivel? tropa.jogador
      if @tropas[0].jogador.eql? tropa.jogador
        @tropas[0].concatena tropa
      elsif @tropas[1].jogador.eql? tropa.jogador
        @tropas[1].concatena
      elsif @tropas[0].nil?
        @tropas[0] = tropa
      else
        @tropas[1] = tropa
      end
      true
    else
      false
    end
  end

  # @param [Tropa] tropa
  # @return [TrueClass]
  # @return [FalseClass]
  def desocupa tropa
    #TODO: Pensar na utilidade do método
    if @tropas[0].eql? tropa
      @tropas[0] = nil
      true
    elsif @tropas[1].eql? tropa
      @tropas[1] = nil
      true
    end
    false
  end

end