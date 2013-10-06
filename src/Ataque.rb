# -*- encoding : utf-8 -*-

require_relative 'Local'
require_relative 'Tropa'

class Ataque

  attr_reader :local
  attr_reader :tropa_atacante, :tropa_defensora

  # @param [Local] Local onde esta sendo realizada a batalha
  # @param [Tropa] tropa_atacante
  # @param [Tropa] tropa_defensora
  def initialize local, tropa_atacante, tropa_defensora
    @local = local
    @tropa_atacante = tropa_atacante
    @tropa_defensora = tropa_defensora
  end

  # @return [FalseClass, TrueClass] retorna false se batalha ainda não acabou
  def executar
    if local.is_cidade
      # Ataque com bônus
      # Com o parâmetro bonus para facilitar a implementação
      tropa_defensora.atacar tropa_atacante true
    else
      # Ataque sem bônus
      tropa_atacante.atacar tropa_defensora false
    end
    return terminou?
  end

  private

  # @return [FalseClass,TrueClass] retorna true se batalha acabou
  def terminou?
    true if tropa_atacante.tamanho == 0 or tropa_defensora.tamanho == 0 or tropa_atacante.local != tropa_defensora.local
  end

end