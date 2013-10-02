require_relative 'Modo'
require_relative 'ModoPartida'

class ModoNovoJogo < Modo

  def initialize jogo
    super jogo
    @comandos = [:exit, :help, :criar_jogador, :status, :iniciar]
  end

  def sufixar
    print "new-game ~> "
  end

  def help
    puts "  Opções de criação de novo jogo:"
    puts "    help                 - Exibe este texto de ajuda"
    puts "    exit                 - Encerra o jogo"
    puts "    criar_jogador [nome] - Cria um novo jogador com o nome passado"
    puts "    status               - Mostra os jogadores atuais"
    puts "    iniciar              - Inicia a partida com os jogadores atuais, iniciando o modo 'partida'"
    puts ""
  end

  def criar_jogador nome
    jogo.criar_jogador nome
    puts "Jogador #{nome} criado!"
  end

  def status
    if @jogo.jogadores.size == 0 then
      puts "[Nenhum jogador criado]"
      return
    end

    puts "[Jogadores atualmente cadastrados]"
    @jogo.jogadores.each do |jogador|
      puts "  ##{jogador.id} #{jogador.nome}"
    end
    puts ""
  end

  def iniciar
    begin
      @jogo.iniciar
    rescue CitygameException => e
      error_msg e.to_s
      return
    end

    modo_partida = ModoPartida.new(@jogo)
    puts "Partida iniciada!"
    return modo_partida
  end

end
