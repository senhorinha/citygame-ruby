class Tropa

  attr_reader :local, :tamanho, :jogador, :forca_de_ataque
  
  NUMERO_DE_OURO = 1.618033
  
  def initialize jogador, tamanho, local
    @local = local
    @jogador = jogador
    @tamanho = tamanho
  end

  def atualiza_forca_de_ataque tecnologia
    @forca_de_ataque = tecnologia * tamanho
  end

  def ataca tropa_inimiga

    forca_de_ataque_inimigo = tropa_inimiga.forca_de_ataque

    funcao_cerco = funcao_cerco(forca_de_ataque_inimigo)

    #caso_um   : Se a força da tropa de ataque for maior que a força da tropa de defesa
    caso_um = ((@forca_de_ataque/forca_de_ataque_inimigo)**NUMERO_DE_OURO)*(1/funcao_cerco(forca_de_ataque_inimigo))
    #caso_dois : Se a força da tropa de defesa for maior que a força da tropa de ataque
    caso_dois = (1/funcao_cerco)

    if(@forca_de_ataque > forca_de_ataque_inimigo)
      atualiza_valores_pos_batalha caso_um
      tropa_inimiga.atualiza_valores_pos_batalha caso_dois
    else
      atualiza_valores_pos_batalha caso_dois
      tropa_inimiga.atualiza_valores_pos_batalha caso_um
    end
  end

  # Atualiza tamanho da tropa e valor de ataque
  
  protected
  
  def atualiza_valores_pos_batalha resultado
    tecnologia_aux = @forca_de_ataque/tamanho
    tamanho *= resultado
    atualiza_forca_de_ataque(tecnologia_aux)
  end

  private

  def funcao_cerco(forca_de_ataque_inimigo)
    return Math.sqrt((@forca_de_ataque*forca_de_ataque_inimigo)/10*(@forca_de_ataque+forca_de_ataque_inimigo))
  end

end
