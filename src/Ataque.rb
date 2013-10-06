# -*- encoding : utf-8 -*-

require_relative 'Local'
require_relative 'Tropa'

# Classe abstract para uso do design pattern Template.
class Ataque

  attr_reader :local
  attr_reader :tropa_atacante, :tropa_defensora
  attr_reader :forca_do_atacante, :forca_do_defensor

  PHI = (1 + Math.sqrt(5))/2

  # @param [Local] local onde esta sendo realizada a batalha
  # @param [Tropa] tropa_atacante
  # @param [Tropa] tropa_defensora
  def initialize local, tropa_atacante, tropa_defensora
    @local = local
    @tropa_atacante = tropa_atacante
    @tropa_defensora = tropa_defensora
    @forca_do_atacante = 0
    @forca_do_defensor = 0
  end

  # @return [FalseClass, TrueClass] Executa batalha e retorna false se nenhuma tropa foi derrotada.
  def executar
    @forca_do_atacante.atualizar_forca
    @forca_do_defensor.atualizar_forca

    @forca_do_atacante = @tropa_atacante.forca
    @forca_do_defensor = calcula_forca_de_defesa

    if @forca_do_atacante > @forca_do_defensor
      @tropa_atacante.atualizar_valores_pos_batalha caso_um
      @tropa_defensora.atualizar_valores_pos_batalha caso_dois
    else
      @tropa_atacante.atualizar_valores_pos_batalha caso_dois
      @tropa_defensora.atualizar_valores_pos_batalha caso_um
    end
    return terminou?
  end

  private

  def calcula_forca_de_defesa
  end

  # @return [Fixnum]
  def funcao_cerco
    Math.sqrt((@forca_do_atacante*@forca_do_defensor)/10*(@forca_do_atacante+@forca_do_defensor))
  end

  #caso_um   : Se a força da tropa de ataque for maior que a força da tropa de defesa
  def caso_um
    ((@forca_do_atacante/@forca_do_defensor)**PHI)*(1/funcao_cerco)
  end

  #caso_dois : Se a força da tropa de defesa for maior que a força da tropa de ataque
  def caso_dois
    1/funcao_cerco
  end


  # @return [FalseClass,TrueClass] retorna true se batalha acabou
  def terminou?
    true if @tropa_atacante.tamanho == 0 or @tropa_defensora.tamanho == 0 or @tropa_atacante.local != @tropa_defensora.local
  end

end
