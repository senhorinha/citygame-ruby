# -*- encoding : utf-8 -*-

require_relative 'Local'
require_relative 'Jogador'

class Tropa
  attr_reader :tamanho, :jogador
  attr_accessor :local

  # @param [Jogador] jogador
  # @param [Fixnum] tamanho
  # @param [Local] local
  def initialize jogador, tamanho, local
    @local = local
    @jogador = jogador
    @tamanho = tamanho
  end

  def forca
    return @jogador.tecnologia * @tamanho
  end

  # Movimenta uma quantidade de soldados da tropa para um novo local adjacente
  # @param [Fixnum] n_soldados Número de soldados a serem movidos
  # @param [Local] local_novo
  def movimentar n_soldados, local_novo
    tropa_em_movimento = separar n_soldados
    local_novo.ocupar tropa_em_movimento

    if tropa_em_movimento == self
      @local.desocupar tropa_em_movimento
    end

    tropa_em_movimento.local = local_novo
  end

  # Concatena a tropa com outra, aumentando o número de soldados da tropa do objeto atual
  # @param [Tropa] tropa
  def concatenar tropa
    raise ArgumentError, 'Não é possível concatenar tropas de diferentes jogadores' unless @jogador.eql? tropa.jogador

    @tamanho += tropa.tamanho
    return self
  end

  # Reduz o número de soldados na tropa.
  # @param [Integer] n_soldados: Número de soldados a serem reduzidos da tropa atual
  def aniquilar n_soldados
    @tamanho -= n_soldados
    @tamanho = 0 if @tamanho < 1
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
    return tropa_separada
  end

end
