class Tropa

  attr_reader :local, :tamanho, :jogador, :forcaDeAtaque
  def initialize jogador, tamanho, local
    @local = local
    @jogador = jogador
    @tamanho = tamanho
  end

  def atualizaForcaDeAtaque tecnologia
    forcaDeAtaque = tecnologia * tamanho
  end

  def ataca tropaInimiga

    forcaDeAtaqueInimigo = tropaInimiga.forcaDeAtaque

    numeroDeOuro = 1.618033
    funcaoCerco = funcaoCerco(forcaDeAtaqueInimigo)

    #CasoUm   : Se a força da tropa de ataque for maior que a força da tropa de defesa
    casoUm = ((forcaDeAtaque/forcaDeAtaqueInimigo)**numeroDeOuro)*(1/funcaoCerco(forcaDeAtaqueInimigo))
    #CasoDois : Se a força da tropa de defesa for maior que a força da tropa de ataque
    casoDois = (1/funcaoCerco)

    if(forcaDeAtaque > forcaDeAtaqueInimigo)
      atualizaValoresPosBatalha casoUm
      tropaInimiga.atualizaValoresPosBatalha casoDois
    else
      atualizaValoresPosBatalha casoDois
      tropaInimiga.atualizaValoresPosBatalha casoUm
    end
  end

  # Atualiza tamanho da tropa e valor de ataque
  def atualizaValoresPosBatalha resultado
    tecnologiaAux = forcaDeAtaque/tamanho
    tamanho *= resultado
    atualizaForcaDeAtaque(tecnologiaAux)
  end

  private

  def funcaoCerco(forcaDeAtaqueInimigo)
    return Math.sqrt((forcaDeAtaque*forcaDeAtaqueInimigo)/10*(forcaDeAtaque+forcaDeAtaqueInimigo))
  end

end
