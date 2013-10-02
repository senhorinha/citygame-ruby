require_relative '../../src/Jogo'
require_relative 'CommandParser'
require_relative 'ModoNovoJogo'

puts "*************************************************"
puts "CITYGAME RUBY - VERSÃO BASEADA SOMENTE EM TEXTO"
puts "*************************************************"
puts "Digite 'help' a qualquer momento para visualizar os comandos disponíveis"
puts "Chame seus amigos e divirta-se :)"
puts ""

jogo = Jogo.new
parser = CommandParser.new
modo = ModoNovoJogo.new jogo

while modo.ativo do
  modo.sufixar()
  command_hash = parser.parse(gets)

  modo = modo.submeter_comando command_hash
end
