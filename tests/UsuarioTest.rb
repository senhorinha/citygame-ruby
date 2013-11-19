# -*- encoding : utf-8 -*-

require 'test/unit'
require_relative '../src/Usuario'

class UsuarioTest < Test::Unit::TestCase

  def setup
    usuario = Usuario.new
  end

  def testar_vazio
    assert 1
  end

end
