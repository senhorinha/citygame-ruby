# -*- encoding : utf-8 -*-

require_relative 'Local'
require_relative 'Jogador'

class Tropa

  attr_reader :local, :tamanho, :jogador, :forca

  # @param [Jogador] jogador
  # @param [Fixnum] tamanho
  # @param [Local] local
  def initialize jogador, tamanho, local
    @local = local
    @jogador = jogador
    @tamanho = tamanho
  end

  def atualizar_forca
    @forca = @jogador.tecnologia * @tamanho
  end

  # Movimenta uma quantidade de soldados da tropa para um novo local adjacente
  # @param [Fixnum] n_soldados Número de soldados a serem movidos
  # @param [Local] local_novo
  def movimentar n_soldados, local_novo
    tropa_em_movimento = separar n_soldados
    local_novo.ocupar tropa_em_movimento

    if tropa_em_movimento == self
      @local.desocupar tropa_em_movimento
      @local = local_novo
    end
  end

  # Concatena a tropa com outra, aumentando o número de soldados da tropa do objeto atual
  # @param [Tropa] tropa
  def concatenar tropa
    raise ArgumentError, 'Não é possível concatenar tropas de diferentes jogadores' unless @jogador.eql? tropa.jogador

    @tamanho += tropa.tamanho
    atualizar_forca
    return self
  end

  # Atualiza tamanho da tropa e valor de ataque
  # @param [Fixnum] resultado
  def atualizar_valores_pos_batalha resultado
    @tamanho -= resultado
    atualizar_forca
  end

  private

  # Retorna um novo objeto Tropa com o tamanho estipulado. Caso o tamanho de separação seja igual ao tamanho da tropa, a própria tropa é retornada
  # @param [Fixnum] n_soldados representa a quantidade de soldados que serão separados da tropa inicial
  # @return [Tropa] Uma nova tropa com valores de ataque atualizados
  def separar n_soldados
    return self if n_soldados == @tamanho

    if n_soldados < 1 || n_soldados > @tamanho then
      raise NumeroDeExercitosException, "Número de soldados fora do intervalo permitido [1, #{@tamanho}]"
    end

    @tamanho -= n_soldados
    tropa_separada = Tropa.new(@jogador, n_soldados, @local)
    tropa_separada.atualizar_forca
    self.atualizar_forca
    return tropa_separada
  end

end
