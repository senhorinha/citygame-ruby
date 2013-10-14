# -*- encoding : utf-8 -*-

require 'test/unit'
require_relative '../src/Tropa'
require_relative '../src/Cidade'
require_relative '../src/Local'

class TropaTest < Test::Unit::TestCase

  def setup
    @jogador = Jogador.new 1, "Napoleão"
    @cidade = Cidade.new 1
    @tropa = Tropa.new @jogador, 10, @cidade

    @jogador_inimigo = Jogador.new 2, "Alexandre"
    @tropa_inimiga = Tropa.new @jogador_inimigo, 10, @cidade

    @local2 = Local.new 2
  end

  def testar_ocupacao_da_tropa_no_momento_de_criacao
    nova_cidade = Cidade.new 3
    tropa = Tropa.new @jogador, 3, nova_cidade
    assert_equal nova_cidade, tropa.local
    assert_equal 1, nova_cidade.tropas.size
    assert_equal tropa, nova_cidade.tropas[0]
  end

  def testar_forca
    assert @tropa.forca == @tropa.tamanho * @jogador.tecnologia
  end

  def testar_movimentar_toda_a_tropa
    @tropa.movimentar @tropa.tamanho, @local2

    assert !@cidade.tropas.include?(@tropa) # Deve ter saído da cidade de origem
    assert @local2.tropas.include?(@tropa) # Deve ter chegado na cidade de destino
    assert_equal @local2, @tropa.local
  end

  def testar_movimentar_tropas_inexistentes
    assert_raise NumeroDeTropasException do
      @tropa.movimentar 20000, @local2
    end

    assert_equal @cidade, @tropa.local
  end

  def testar_movimentar_parte_da_tropa
    @tropa.movimentar 2, @local2
    assert_equal 2, @local2.tropas[0].tamanho
    assert_equal 8, @cidade.tropas[0].tamanho
  end

  def testar_concatenar_tropas_de_diferentes_jogadores
    assert_raise ArgumentError do
      @tropa.concatenar @tropa_inimiga
    end
  end

  def testar_concatenar_tropas
    tropa2 = Tropa.new @jogador, 4, @cidade
    @tropa.concatenar tropa2
    assert_equal 14, @tropa.tamanho
    assert_equal 0, tropa2.tamanho
  end

  def testar_aniquilar
    @tropa.aniquilar 2
    assert_equal 8, @tropa.tamanho
    @tropa.aniquilar 100
    assert_equal 0, @tropa.tamanho
  end

  def testar_concatenar_tropas_ao_mover
    tropa2 = Tropa.new @jogador, 7, nil
    tropa2.movimentar 3, @cidade
    assert_equal 13, @tropa.tamanho # Deve ter concatenado com @tropa
    tropa2.movimentar 4, @cidade
    assert_equal 17, @tropa.tamanho # Deve ter concatenado com @tropa
    assert_equal 0, tropa2.tamanho # Tropa original deve ter sido 'diluída'
  end

end
