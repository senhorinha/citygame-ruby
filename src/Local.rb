# -*- encoding : utf-8 -*-

require_relative 'Tropa'
require_relative 'Jogador'
require_relative 'atividades/AtAtaqueRural'
require_relative 'atividades/AtAtaqueUrbano'

class Local

  attr_reader :id, :tropas

  # @param [Fixnum] id identificador do Local
  def initialize id
    @id = id
    @tropas = []
  end

  def is_cidade
    return false
  end

  # Adiciona a tropa ao local atual, concatenando com tropas amigas
  # @param [Tropa] tropa
  def ocupar tropa
    # Checa se existem tropas amigas no local, se sim, mescla as tropas
    @tropas.each do |outra_tropa|
      if outra_tropa.jogador == tropa.jogador
        outra_tropa.concatenar(tropa)
        checar_batalhas outra_tropa
        return
      end
    end

    @tropas.push tropa
    checar_batalhas tropa
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
        if is_cidade then
          tropa_atacante.jogador.adicionar_atividade AtAtaqueUrbano.new(self, tropa_atacante, tropa)
        else
          tropa_atacante.jogador.adicionar_atividade AtAtaqueRural.new(self, tropa_atacante, tropa)
        end
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
      if tropa.jogador == jogador then
        tropa_jogador = tropa
        break
      end
    end

    return tropa_jogador
  end

end
