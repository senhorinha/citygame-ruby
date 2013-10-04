# -*- encoding : utf-8 -*-

class Tropa

  attr_reader :local, :tamanho, :jogador, :forca_de_ataque

  NUMERO_DE_OURO = 1.618033

  # @param [Jogador] jogador
  # @param [Fixnum] tamanho
  # @param [Local] local
  def initialize jogador, tamanho, local
    @local = local
    @jogador = jogador
    @tamanho = tamanho
  end

  # @param [Fixnum] tecnologia
  def atualiza_forca_de_ataque
    @forca_de_ataque = @jogador.tecnologia * @tamanho
  end

  # @param [Fixnum] quantidade_de_exercitos
  # @param [Local] local_novo
  # @return [Tropa] retorna a mesma tropa ou uma nova tropa caso precise separar tropa.
  def movimenta quantidade_de_exercitos, local_novo
    if 0 < quantidade_de_exercitos <= @tamanho
      if quantidade_de_exercitos == @tamanho
        tropa = self
      else
        tropa_separada = true
        tropa = separa quantidade_de_exercitos
      end
      if (local_novo.ocupa(tropa))
        @local = local_novo
        tropa
      else
        if tropa_separada
          @tamanho += quantidade_de_exercitos
          atualiza_forca_de_ataque
          self
        end
      end
    else
      raise ArgumentError, "Quantidade de exércitos '#{quantidade_de_exercitos}', fora do intervalo aceitavel [0, #{tamanho_tropa}]"
    end

  end

# @param [Tropa] tropa_inimiga
  def ataca tropa_inimiga
    forca_de_ataque_inimigo = tropa_inimiga.forca_de_ataque
    funcao_cerco = funcao_cerco(forca_de_ataque_inimigo)

    #caso_um   : Se a força da tropa de ataque for maior que a força da tropa de defesa
    caso_um = ((@forca_de_ataque/forca_de_ataque_inimigo)**NUMERO_DE_OURO)*(1/funcao_cerco(forca_de_ataque_inimigo))
    #caso_dois : Se a força da tropa de defesa for maior que a força da tropa de ataque
    caso_dois = (1/funcao_cerco)

    if @forca_de_ataque > forca_de_ataque_inimigo
      atualiza_valores_pos_batalha caso_um
      tropa_inimiga.atualiza_valores_pos_batalha caso_dois
    else
      atualiza_valores_pos_batalha caso_dois
      tropa_inimiga.atualiza_valores_pos_batalha caso_um
    end
  end

# @param [Tropa] tropa
  def concatena tropa
    if @jogador.eql? tropa.jogador then
      @tamanho += tropa.tamanho
      atualiza_forca_de_ataque
      tropa = self # Como há uma concatenação ambos referenciarão a mesma instância.
      self
    else
      raise ArgumentError, 'Não é possível concatenar tropas de diferentes jogadores'
    end
  end

  protected

# Atualiza tamanho da tropa e valor de ataque
# @param [Fixnum] resultado
  def atualiza_valores_pos_batalha resultado
    @tamanho *= resultado
    atualiza_forca_de_ataque
  end

  private

# @param [Fixnum] forca_de_ataque_inimigo
  def funcao_cerco forca_de_ataque_inimigo
    Math.sqrt((@forca_de_ataque*forca_de_ataque_inimigo)/10*(@forca_de_ataque+forca_de_ataque_inimigo))
  end

# @param [Fixnum] quantidade_de_exercitos
# @return [Tropa] Uma nova tropa com valores de ataque atualizados
  def separa quantidade_de_exercitos
    @tamanho -= quantidade_de_exercitos
    tropa_separada = Tropa.new(@jogador, quantidade_de_exercitos, @local)
    tropa_separada.atualiza_forca_de_ataque
    tropa_separada
  end

end
