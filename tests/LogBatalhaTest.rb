# -*- encoding : utf-8 -*-

require 'test/unit'
require_relative '../src/LogBatalha'

class LogBatalhaTest < Test::Unit::TestCase

  def setup
    log = LogBatalha.new
  end

  def testar_vazio
    assert 1
  end

end
