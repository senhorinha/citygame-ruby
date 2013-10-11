# -*- encoding : utf-8 -*-

require 'test/unit'
require_relative '../src/Jogador'
require_relative '../src/Cidade'
require_relative '../src/atividades/Atividade'

class AtTest < Atividade

  def executar turno
    return true
  end

end

class JogadorTest < Test::Unit::TestCase

  def setup
    @jogador = Jogador.new 1, "Napoleão"
    @cidade = Cidade.new 1
  end

  def testar_atribuir_cidade
    @jogador.atribuir_cidade @cidade
    assert @jogador.cidades.include?(@cidade)
    assert_equal @jogador, @cidade.jogador
  end

  def testar_executar_atividades
    at_test = AtTest.new
    @jogador.adicionar_atividade at_test
    assert @jogador.fila_de_atividades.include?(at_test)

    @jogador.executar_atividades(1)
    assert_equal 0, @jogador.fila_de_atividades.size
  end

   def testar_gerar_recursos
    @jogador.atribuir_cidade @cidade
    @cidade.balancear_recursos 5, 5
    @jogador.gerar_recursos

    assert_equal 1.05, @jogador.tecnologia
    assert_equal 5, @cidade.tropas[0].tamanho
    assert_equal @jogador, @cidade.tropas[0].jogador

    @jogador.gerar_recursos

    assert_equal 1.1025, @jogador.tecnologia
    assert_equal 10, @cidade.tropas[0].tamanho
    assert_equal @jogador, @cidade.tropas[0].jogador
    assert_equal 1, @cidade.tropas.size
  end

end
