# -*- encoding : utf-8 -*-

require 'test/unit'
require_relative '../src/Usuario'
require_relative '../src/persistencia/DAOLogBatalha'
require_relative '../src/LogBatalha'

class DAOLogBatalhaTest < Test::Unit::TestCase

  def setup
    @dao = DAOLogBatalha.new
    @usuario_1 = Usuario.new "Luis_IV", "r31d4guerr4","r31d4guerr4"
    @usuario_2 = Usuario.new "napoleao", "r31d4guerr4","r31d4guerr4"
    @log = LogBatalha.new
    @log.turnos = 10
    @log.adicionar_jogador @usuario_1
    @log.adicionar_jogador @usuario_2
    @log.vencedor = @usuario_2
  end

  def test_cadastrar_log
    @dao.create @log
    puts "Verifique se o banco possui registro de batalha com [vencedor : #{@log.vencedor.username} | turnos: #{@log.turnos}]"
  end

  def test_buscar_batalhas_vencidas
   batalhas = @dao.read_batalhas_vencidas_por @usuario_2

   contador = 0;
   batalhas.each do |batalha|
      if(batalha.vencedor.username == 'napoleao')
          contador = contador + 1
      end
   end
   assert_equal contador, batalhas.size
  end

end
