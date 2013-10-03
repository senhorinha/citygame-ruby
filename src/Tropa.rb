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
  def atualiza_forca_de_ataque tecnologia
    @forca_de_ataque = tecnologia * tamanho
  end

  # @param [Fixnum] quantidade_de_exercitos
  # @param [Local] local_novo
  # @return [Tropa] retorna a mesma tropa ou uma nova tropa caso precise separar tropa.
  def movimenta quantidade_de_exercitos, local_novo
    if (quantidade_de_exercitos == @tamanho)
      @local = local_novo
      self
    else
      if (quantidade_de_exercitos < @tamanho || quantidade_de_exercitos > 0)
        separa quantidade_de_exercitos, local_novo
      end
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
    else
      false
    end
  end

  protected

  # Atualiza tamanho da tropa e valor de ataque
  # @param [Fixnum] resultado
  def atualiza_valores_pos_batalha resultado
    tecnologia_aux = @forca_de_ataque/tamanho
    tamanho *= resultado
    atualiza_forca_de_ataque(tecnologia_aux)
  end

  private

  # @param [Fixnum] forca_de_ataque_inimigo
  def funcao_cerco forca_de_ataque_inimigo
    Math.sqrt((@forca_de_ataque*forca_de_ataque_inimigo)/10*(@forca_de_ataque+forca_de_ataque_inimigo))
  end

  # @param [Fixnum] quantidade_de_exercitos
  # @param [Local] local_novo
  def separa quantidade_de_exercitos, local_novo
    if quantidade_de_exercitos <= @tamanho
      if quantidade_de_exercitos != @tamanho
        @tamanho -= quantidade_de_exercitos
        Tropa.new(@jogador, quantidade_de_exercitos, local_novo)
      else
        #TODO: Criar mecanismo para mover a tropa para o local_novo
      end
    end
  end

end