# -*- encoding : utf-8 -*-

require 'test/unit'
require_relative '../src/Jogo'
require_relative '../src/Jogador'

class JogoTest < Test::Unit::TestCase

  def setup
    @jogo = Jogo.new
    @jogo.criar_jogador 'Napoleão'
    @jogo.criar_jogador 'César'

    @napoleao = @jogo.jogadores[0]
    @cesar = @jogo.jogadores[1]

    @jogo_sem_jogadores = Jogo.new
  end

  def test_criar_jogador
    @jogo_sem_jogadores.criar_jogador 'Napoleão'
    assert_equal 1, @jogo_sem_jogadores.jogadores.size
    assert_equal 'Napoleão', @jogo_sem_jogadores.jogadores[0].nome

    @jogo_sem_jogadores.criar_jogador 'César'
    assert_equal 2, @jogo_sem_jogadores.jogadores.size
    assert_equal 'César', @jogo_sem_jogadores.jogadores[1].nome
  end

  def test_iniciar_sem_jogadores
    assert_raise MinimoDeJogadoresException do
      @jogo_sem_jogadores.iniciar
    end
  end

  def test_criar_jogador_depois_de_iniciada_a_partida
    @jogo.iniciar

    assert_raise NovoJogadorException do
      @jogo.criar_jogador 'Colombo'
    end
  end

  def test_iniciar
    @jogo.iniciar

    # Testar se os mapas foram criados:
    assert_equal false, @jogo.mapa.campos.empty?
    assert_equal false, @jogo.mapa.cidades.empty?

    # Testa se existe jogador atual
    assert_equal true, @jogo.jogadores.include?(@jogo.jogador_atual)

    # Testa se foram atribuídas cidades aos jogadores
    @jogo.jogadores.each do |jogador|
      assert_equal 1, jogador.cidades.size
    end
  end

  def test_passar_a_vez
    @jogo.iniciar
    primeiro_jogador = @jogo.jogador_atual
    assert_equal 1, @jogo.turno

    @jogo.passar_a_vez
    segundo_jogador = @jogo.jogador_atual
    assert_equal 2, @jogo.turno
    assert_not_equal primeiro_jogador, segundo_jogador

    @jogo.passar_a_vez
    assert_equal primeiro_jogador, @jogo.jogador_atual
  end

  def test_remover_jogador_perdedor_ao_passar_a_vez
    @jogo.iniciar

    paris = @napoleao.cidades[0]
    @napoleao.cidades.clear
    @napoleao.tropas.clear

    assert_equal 2, @jogo.jogadores.size
    @jogo.jogadores.size.times do
      @jogo.passar_a_vez
    end
    assert_equal 1, @jogo.jogadores.size
    assert_equal false, @jogo.jogadores.include?(@napoleao)
  end

  def test_terminou?
    @jogo.iniciar
    assert_equal false, @jogo.terminou?
    @jogo.jogadores.delete @napoleao
    assert_equal true, @jogo.terminou?
  end

end
