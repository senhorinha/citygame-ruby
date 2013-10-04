# -*- encoding : utf-8 -*-
class Modo
  attr_reader :ativo, :jogo, :comandos

  def initialize jogo
    @comandos = []
    @ativo = true
    @jogo = jogo
  end

  def sufixo
    return ' ~> '
  end

  def completion_proc
    return proc { |s| comandos.grep(/^#{s}/) }
  end

  def submeter_comando command_hash
    if !validar_comando(command_hash[:command]) then
      error_msg "'#{command_hash[:command]}' não é um comando válido... Digite 'help' caso esteja perdido!"
      return self
    end

    begin
      if command_hash[:options].empty?
        r = self.send(command_hash[:command])
      else
        r = self.send(command_hash[:command], *command_hash[:options])
      end
    rescue => e
      error_msg "Número de argumentos inválido. Digite 'help' para ver o número correto de argumentos do comando"
    end

    return r if r.kind_of? Modo
    return self
  end

  def confirmar_comando msg
    print msg.colorize(:yellow), " (s, n) "
    c = gets
    c = c.strip.downcase
    return c == 's'
  end

  def success_msg msg
    puts msg.colorize :green
  end

  def warning_msg msg
    puts msg.colorize :yellow
  end

  def error_msg msg
    puts msg.colorize :red
  end

private

  def validar_comando comando
    return false if !@comandos.include?(comando)
    return false if comando.empty?

    return true
  end

public

  # ========================================================
  # Comandos padrões

  def exit
    c = confirmar_comando "Encerrar o jogo, perdendo todas as informações?"
    @ativo = !c
  end

end
