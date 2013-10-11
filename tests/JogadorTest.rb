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
    assert @cidade.jogador == @jogador
  end

  def testar_executar_atividades
    at_test = AtTest.new
    @jogador.adicionar_atividade at_test
    assert @jogador.fila_de_atividades.include? at_test

    @jogador.executar_atividades(1)
    assert @jogador.fila_de_atividades.size == 0
  end

   def testar_gerar_recursos
    @jogador.atribuir_cidade @cidade
    @cidade.balancear_recursos 5, 5
    @jogador.gerar_recursos

    assert @jogador.tecnologia == 1.05
    assert @cidade.tropas[0].tamanho == 5
    assert @cidade.tropas[0].jogador == @jogador

    @jogador.gerar_recursos

    assert @jogador.tecnologia == 1.1025
    assert @cidade.tropas[0].tamanho == 10
    assert @cidade.tropas[0].jogador == @jogador
    assert @cidade.tropas.size == 1
  end

end
