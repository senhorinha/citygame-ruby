# -*- encoding : utf-8 -*-

class Local
  attr_reader :id, :tropas

  def initialize id
    @id = id
    @tropas = []
  end

  # Adiciona a tropa ao local atual, concatenando com tropas amigas
  # @param [Tropa] tropa
<<<<<<< HEAD
  # @return [TrueClass]
  # @return [FalseClass]
  def ocupa tropa
    #TODO: Resolver esse monte de ifs
    #TODO: Ataque automatico quando detectado tropas de jogadores diferentes.
    if local_disponivel? tropa.jogador
      if @tropas[0].jogador.eql? tropa.jogador
        @tropas[0].concatena tropa
      elsif @tropas[1].jogador.eql? tropa.jogador
        @tropas[1].concatena
      elsif @tropas[0].nil?
        @tropas[0] = tropa
      else
        @tropas[1] = tropa
=======
  def ocupar tropa
    # Checa se existem tropas amigas no local, se sim, mescla as tropas
    @tropas.each do |outra_tropa|
      if outra_tropa.jogador == tropa.jogador then
        outra_tropa.concatenar(tropa)
        return
>>>>>>> b7d155ddaf9c89d5d08958e26b5e9cc4bb914091
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
