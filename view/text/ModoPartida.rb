require_relative 'Modo'

class ModoPartida < Modo

  def initialize jogo
    super jogo
    @comandos = [:exit, :help, :passar]
  end

  def sufixo
    return "turno#{@jogo.turno} @ #{@jogo.jogador_atual.nome} ~> "
  end

  def help
    puts "  Opções de partida:"
    puts "    help                 - Exibe este texto de ajuda"
    puts "    exit                 - Encerra o jogo"
    puts "    passar               - Passa a vez"
    puts ""
  end

  def passar
    @jogo.passar_a_vez
  end

end
