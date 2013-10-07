# -*- encoding : utf-8 -*-

require_relative 'Local'
require_relative 'Tropa'
require_relative 'Ataque'
require_relative 'AtaqueRural'
require_relative 'AtaqueUrbano'

class FilaDeAtaques

  attr_reader :ataques


  def initialize
    @ataques = []
  end

  # @param [Local] local onde será travada a batalha
  # @param [Tropa] tropa_atacante
  # @param [Tropa] tropa_defensora
  def adicionar local, tropa_atacante, tropa_defensora

    @ataques.each do |ataque|
      # Não adiciona ataque pois só houve concatenação e referências já estão atualizadas
      if ataque.local.eql? local
        return false
      end
    end

    if local.is_cidade
      @ataques.push AtaqueUrbano.new local, tropa_atacante, tropa_defensora
    else
      @ataques.push AtaqueRural.new local, tropa_atacante, tropa_defensora
    end
    true

  end

  # Executa todos os ataques presentes na fila
  def executar_ataques
    #Percorre a fila executando os ataques
    @ataques.each do |ataque|
      #Se batalha acabou, retira-o da fila
      if ataque.executar
        @ataques.pop ataque
      end
    end
  end


end