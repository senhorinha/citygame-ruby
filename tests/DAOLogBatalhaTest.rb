# -*- encoding : utf-8 -*-

require_relative '../src/Usuario'
require_relative '../src/persistencia/DAOLogBatalha'
require_relative '../src/LogBatalha'
require 'test/unit'

class DAOLogBatalhaTest < Test::Unit::TestCase

  def setup
    @dao = DAOLogBatalha.new
    @usuario_1 = Usuario.new "Luis_IV", "r31d4guerr4"
    @usuario_2 = Usuario.new "napoleao", "r31d4guerr4"
    @log = LogBatalha.new
    @log.adicionar_jogador @usuario_1
    @log.adicionar_jogador @usuario_2
  end

  def test_cadastrar_log
    @dao.create @log
    puts "Verifique o banco!"
  end

  def test_buscar_batalhas_vencidas
   batalhas = @dao.read_batalhas_vencidas_por @usuario_2
   assert_equal 1, batalhas.size
  end

end
