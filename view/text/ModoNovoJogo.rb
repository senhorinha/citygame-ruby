# -*- encoding : utf-8 -*-
require_relative 'Modo'
require_relative 'ModoPartida'

class ModoNovoJogo < Modo

  def initialize jogo
    super jogo
    @comandos = ['exit', 'help', 'registrar', 'login', 'criar_jogador', 'status', 'iniciar']
  end

  def prefixo
    return 'new-game ~> '
  end

  def help
    puts "  Opções de criação de novo jogo:"
    puts "    * help                 - Exibe este texto de ajuda"
    puts "    * exit                 - Encerra o jogo"
    puts "    * registrar            - Cria um novo jogador e o adiciona na base de dados"
    puts "    * login                - Loga o jogador e o adiciona na partida (username e senha necessários)"
    puts "    * criar_jogador [nome] - Cria um novo jogador com o nome passado"
    puts "    * status               - Mostra os jogadores atuais"
    puts "    * iniciar              - Inicia a partida com os jogadores atuais, iniciando o modo 'partida'"
    puts ""
  end

  def registrar
    username = ask 'username: '
    senha = ask_encrypted 'senha: '
    senha_confirm = ask_encrypted 'confirmação de senha: '
    puts username, senha, senha_confirm
    warning_msg "TODO: Adicionar na base de dados aqui"
  end

  def login
    username = ask 'username: '
    senha = ask_encrypted 'senha: '
    puts username, senha
    warning_msg "TODO: Busca jogador aqui e o adiciona na partida"
  end

  def criar_jogador nome
    jogo.criar_jogador nome
    success_msg "Jogador #{nome} criado!"
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
    success_msg "Partida iniciada!"
    return modo_partida
  end

end
