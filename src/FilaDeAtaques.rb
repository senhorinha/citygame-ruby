class FilaDeAtividades

  attr_reader :tropas_atacantes, :tropas_defensoras


  def initialize jogador
    @tropas_atacantes = []
    @tropas_defensoras = []
  end

  # @param [Tropa] tropa_atacante
  # @param [Tropa] tropa_defensora
  def adicionar_ataque tropa_atacante, tropa_defensora
    @ataques.push tropa_atacante
    @ataques.push tropa_defensora
  end

  def executar_atividades

    for i in 0..30
      tropa_atacante = @tropas_atacantes[i]
      tropa_defensora = @tropa_defensora[i]

      # Se uma das tropas perdeu ou se estão em locais diferentes acaba a batalha
      if tropa_atacante.tamanho == 0 or tropa_defensora.tamanho == 0 or tropa_atacante.local != tropa_defensora.local
        @tropas_atacantes.delete tropa_atacante
        @tropa_defensora.delete tropa_defensora
      end
      tropa_atacante.atacar tropa_defensora
    end
  end


end