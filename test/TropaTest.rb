require 'test/unit'

class TropaTest < Test::Unit::TestCase

  def setup
    jogador = Jogador.new 1, Fernanda
    local_inicial = Local.new 1
    @local_destino = Loca.new 2
    @tropa = Tropa.new jogador, 10, local_inicial
  end


  def deve_saber_calcular_valor_de_forca
    @tropa.atualiza_forca_de_ataque
    assert_equal(10*10, @tropa.forca_de_ataque)
  end
end