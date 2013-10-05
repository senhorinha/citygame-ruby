# -*- encoding : utf-8 -*-

class Tropa
  attr_reader :local, :tamanho, :jogador, :forca_de_ataque

  PHI = (1 + Math.sqrt(5))/2

  # @param [Jogador] jogador
  # @param [Fixnum] tamanho
  # @param [Local] local
  def initialize jogador, tamanho, local
    @local = local
    @jogador = jogador
    @tamanho = tamanho
  end

  def atualizar_forca_de_ataque
    @forca_de_ataque = @jogador.tecnologia * @tamanho
  end

  # Movimenta uma quantidade de soldados da tropa para um novo local adjacente
  # @param [Fixnum] n_soldados Número de soldados a serem movidos
  # @param [Local] local_novo
  # @return [FalseClass,TrueClass]
  def movimentar n_soldados, local_novo

    tropa_em_movimento = separar n_soldados

    return false unless local_novo.ocupar tropa_em_movimento

    if tropa_em_movimento == self
      @local.desocupar tropa_em_movimento
      @local = local_novo
    end
    true
  end

  # Ataca uma tropa inimiga
  # @param [Tropa] tropa_inimiga
  def atacar tropa_inimiga
    forca_de_ataque_inimigo = tropa_inimiga.forca_de_ataque
    funcao_cerco = funcao_cerco(forca_de_ataque_inimigo)

    #caso_um   : Se a força da tropa de ataque for maior que a força da tropa de defesa
    caso_um = ((@forca_de_ataque/forca_de_ataque_inimigo)**PHI)*(1/funcao_cerco)
    #caso_dois : Se a força da tropa de defesa for maior que a força da tropa de ataque
    caso_dois = (1/funcao_cerco)

    if @forca_de_ataque > forca_de_ataque_inimigo
      atualizar_valores_pos_batalha caso_um
      tropa_inimiga.atualizar_valores_pos_batalha caso_dois
    else
      atualizar_valores_pos_batalha caso_dois
      tropa_inimiga.atualizar_valores_pos_batalha caso_um
    end
  end

  # Concatena a tropa com outra, aumentando o número de soldados da tropa do objeto atual
  # @param [Tropa] tropa
  def concatenar tropa
    if @jogador.eql? tropa.jogador then
      @tamanho += tropa.tamanho
      atualizar_forca_de_ataque
      tropa = self # Como há uma concatenação ambos referenciarão a mesma instância.
      self
    else
      raise ArgumentError, 'Não é possível concatenar tropas de diferentes jogadores'
    end
  end

  protected

  # Atualiza tamanho da tropa e valor de ataque
  # @param [Fixnum] resultado
  def atualizar_valores_pos_batalha resultado
    @tamanho *= resultado
    atualizar_forca_de_ataque
  end

  private

  # @param [Fixnum] forca_de_ataque_inimigo
  def funcao_cerco forca_de_ataque_inimigo
    Math.sqrt((@forca_de_ataque*forca_de_ataque_inimigo)/10*(@forca_de_ataque+forca_de_ataque_inimigo))
  end

  # Retorna um novo objeto Tropa com o tamanho estipulado. Caso o tamanho de separação seja igual ao tamanho da tropa, a própria tropa é retornada
  # @param [Fixnum] n_soldados
  # @return [Tropa] Uma nova tropa com valores de ataque atualizados
  def separar n_soldados
    unless 0 < n_soldados <= @tamanho then
      raise ArgumentError, "Quantidade de soldados '#{n_soldados}', fora do intervalo aceitável [1, #{@tamanho}]"
    end

    return self if n_soldados == @tamanho

    @tamanho -= n_soldados
    tropa_separada = Tropa.new(@jogador, n_soldados, @local)
    tropa_separada.atualizar_forca_de_ataque()
    self.atualizar_forca_de_ataque()
    return tropa_separada
  end

end
