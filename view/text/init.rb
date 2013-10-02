require 'colorize'
require 'readline'
require_relative '../../src/Jogo'
require_relative 'CommandParser'
require_relative 'ModoNovoJogo'

puts ""
puts " ______     __     ______   __  __     ______     ______     __    __     ______  "
puts "/\\  ___\\   /\\ \\   /\\__  _\\ /\\ \\_\\ \\   /\\  ___\\   /\\  __ \\   /\\ \"-./  \\   /\\  ___\\   "
puts "\\ \\ \\____  \\ \\ \\  \\/_/\\ \\/ \\ \\____ \\  \\ \\ \\__ \\  \\ \\  __ \\  \\ \\ \\-./\\ \\  \\ \\  __\\   "
puts " \\ \\_____\\  \\ \\_\\    \\ \\_\\  \\/\\_____\\  \\ \\_____\\  \\ \\_\\ \\_\\  \\ \\_\\ \\ \\_\\  \\ \\_____\\ "
puts "  \\/_____/   \\/_/     \\/_/   \\/_____/   \\/_____/   \\/_/\\/_/   \\/_/  \\/_/   \\/_____/ "
puts ""
puts ""

puts "Digite 'help' a qualquer momento para visualizar os comandos disponíveis"
puts "Chame seus amigos e divirta-se :)"
puts ""

jogo = Jogo.new
parser = CommandParser.new
modo = ModoNovoJogo.new jogo

while modo.ativo do
  input = Readline.readline(modo.sufixo, true)
  command_hash = parser.parse(input)

  modo = modo.submeter_comando command_hash
end
