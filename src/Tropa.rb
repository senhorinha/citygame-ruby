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

  def atualizar_forca_de_ataque
    @forca_de_ataque = @jogador.tecnologia * @tamanho
  end

  # Movimenta uma quantidade de soldados da tropa para um novo local adjacente
  # @param [Fixnum] n_soldados Número de soldados a serem movidos
  # @param [Local] local_novo
  def movimentar n_soldados, local_novo
    # TODO: checar se o local_novo é adjacente ao local atual

    tropa_separada = separar n_soldados

    if tropa_separada == self then
      @local.desocupar self
    end

    tropa_separada.local = local_novo
    local_novo.ocupar tropa_separada
  end

  # Ataca uma tropa inimiga
  # @param [Tropa] tropa_inimiga
  def atacar tropa_inimiga
    forca_de_ataque_inimigo = tropa_inimiga.forca_de_ataque
    funcao_cerco = funcao_cerco(forca_de_ataque_inimigo)

    #caso_um   : Se a força da tropa atacante for maior que a força da tropa defensora
    caso_um = ((@forca_de_ataque/forca_de_ataque_inimigo)**NUMERO_DE_OURO)*(1/funcao_cerco(forca_de_ataque_inimigo))
    #caso_dois (condição inversa ao caso_um) : Se a força da tropa defensora for maior que a força da tropa atacante
    caso_dois = (1/funcao_cerco)

    if @forca_de_ataque > forca_de_ataque_inimigo
      atualizar_valores_pos_batalha caso_um
      tropa_inimiga.atualizar_valores_pos_batalha caso_dois
    else
      atualizar_valores_pos_batalha caso_dois
      tropa_inimiga.atualizar_valores_pos_batalha caso_um
    end
  end

<<<<<<< HEAD
# @param [Tropa] tropa
# @return [Tropa]
  def concatena tropa
=======
  # Concatena a tropa com outra, aumentando o número de soldados da tropa do objeto atual
  # @param [Tropa] tropa
  def concatenar tropa
>>>>>>> b7d155ddaf9c89d5d08958e26b5e9cc4bb914091
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

<<<<<<< HEAD
# @param [Fixnum] forca_de_ataque_inimigo
# @return [Fixnum]
=======
  # @param [Fixnum] forca_de_ataque_inimigo
>>>>>>> b7d155ddaf9c89d5d08958e26b5e9cc4bb914091
  def funcao_cerco forca_de_ataque_inimigo
    Math.sqrt((@forca_de_ataque*forca_de_ataque_inimigo)/10*(@forca_de_ataque+forca_de_ataque_inimigo))
  end

<<<<<<< HEAD
# @param [Fixnum] quantidade_de_exercitos
# @return [Tropa] Uma nova tropa com valores de ataque atualizados
  def separa quantidade_de_exercitos
    @tamanho -= quantidade_de_exercitos
    atualiza_forca_de_ataque
    tropa_separada = Tropa.new(@jogador, quantidade_de_exercitos, @local)
    tropa_separada.atualiza_forca_de_ataque
    tropa_separada
=======
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
>>>>>>> b7d155ddaf9c89d5d08958e26b5e9cc4bb914091
  end

end
