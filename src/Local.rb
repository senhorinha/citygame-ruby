# -*- encoding : utf-8 -*-

class Local
  attr_reader :id, :tropas

  def initialize id
    @id = id
    @tropas = []
  end

  # Adiciona a tropa ao local atual, concatenando com tropas amigas
  # @param [Tropa] tropa
  def ocupar tropa
    # Checa se existem tropas amigas no local, se sim, mescla as tropas
    @tropas.each do |outra_tropa|
      if outra_tropa.jogador == tropa.jogador then
        outra_tropa.concatenar(tropa)
        return
      end
    end

    # Se não existem tropas amigas no local, adiciona à lista de tropas
    @tropas.push tropa
  end

  # Retira a tropa do local atual
  # @param [Tropa] tropa
  def desocupar tropa
    @tropas.delete tropa
  end

  # Checa se há tropas inimigas no local. Caso existam, gera as batalhas das tropas, duas a duas
  def checar_batalhas
    # TODO: implementar
  end

end
