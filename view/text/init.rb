# -*- encoding : utf-8 -*-
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
modo = ModoNovoJogo.new jogo # Modo inicial

Readline.completion_append_character = ' ' # Caracter impresso após uma chamada de auto completar

while modo.ativo do
  Readline.completion_proc = modo.completion_proc # Atribui o processo de auto completar ao interpretador de comandos

  input = Readline.readline(modo.prefixo, true) # Lê um novo comando do input padrão, salvando no histórico de comandos digitados
  command_hash = parser.parse(input)            # Interpreta a string digitada

  modo = modo.submeter_comando command_hash     # Submete o comando ao modo de jogo atual, recebendo a instância do próximo modo de jogo (pode ser o mesmo ou um novo)
end
