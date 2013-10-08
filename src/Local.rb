# -*- encoding : utf-8 -*-

require_relative 'Tropa'
require_relative 'Jogador'

class Local

  attr_reader :id, :tropas, :is_cidade

  # @param [Fixnum] id identificador do Local
  # @param [FalseClass,TrueClass] is_cidade true se local for cidade
  def initialize id, is_cidade
    @id = id
    @tropas = []
    @is_cidade = is_cidade
  end

  # Adiciona a tropa ao local atual, concatenando com tropas amigas
  # @param [Tropa] tropa
  # @return [FalseClass,TrueClass]
  def ocupar tropa
    # Checa se existem tropas amigas no local, se sim, mescla as tropas
    @tropas.each do |outra_tropa|
      if outra_tropa.jogador == tropa.jogador
        outra_tropa.concatenar(tropa)
        checar_batalhas outra_tropa
        return true
      end
    end

    # Checa se existem vaga para uma nova tropa (inimiga)
    for i in 0..1
      if @tropas[i].nil?
        @tropas[i] = tropa
        checar_batalhas tropa
        return true
      end
    end

    return false # Não há espaço nesse Local

  end

  # Retira a tropa do local atual
  # @param [Tropa] tropa
  def desocupar tropa
    @tropas.delete tropa
  end

  # Checa se há tropas inimigas no local. Caso existam, gera as batalhas das tropas, duas a duas
  # @param [Tropa] tropa_atacante : Ultima tropa a entrar na local, responsável por iniciar o ataque
  def checar_batalhas tropa_atacante
    @tropas.each do |tropa|
      if !tropa.nil? and tropa != tropa_atacante
        tropa_atacante.jogador.adicionar_ataque self, tropa_atacante, tropa
      end
    end
  end

  # Elimina as tropas nulas ou de tamanho 0 do local
  def limpar_os_mortos
    @tropas.each do |tropa|
      @tropas.delete tropa if tropa.nil? or tropa.tamanho < 1
    end
  end

  # Retorna a tropa do jogador presente no local, ou nil se não existem tropas do jogador no local
  # @param [Jogador]
  # @return [Tropa]
  def get_tropa_jogador jogador
    tropa_jogador = nil

    @tropas.each do |tropa|
      tropa_jogador = tropa if tropa.jogador == jogador
    end

    return tropa_jogador
  end

end
