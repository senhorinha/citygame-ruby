# -*- encoding : utf-8 -*-

require 'test/unit'
require_relative '../src/persistencia/Conexao'
require_relative '../src/persistencia/DAOUsuario'
require_relative '../src/Usuario'

class DAOUsuarioTest < Test::Unit::TestCase

  def setup
    @dao = DAOUsuario.new
  end

  def test_cadastrar_e_buscar_usuario
    @dao.create "napoleao", "r31d4guerr4"
    usuario = @dao.read "napoleao", "r31d4guerr4"
    assert_equal 'napoleao', usuario.username
    assert_equal 'r31d4guerr4', usuario.password
  end

end
