require_relative '../../src/Jogo'
require_relative '../../src/Cidade'

jogo = Jogo.new

jogo.criar_jogador "Bruno"
jogo.criar_jogador "Carlos"

jogo.iniciar
