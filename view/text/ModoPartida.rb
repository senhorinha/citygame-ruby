# -*- encoding : utf-8 -*-
require_relative '../../src/Jogo'
require_relative 'Modo'

class ModoPartida < Modo

  def initialize jogo
    super jogo
    @comandos = ['exit', 'help', 'passar', 'status', 'map', 'balancear', 'move']
  end

  def prefixo
    return "turno#{@jogo.turno} @ #{@jogo.jogador_atual.nome} ~> "
  end

  def help
    puts "  Opções de partida:"
    puts "   * help                                     - Exibe este texto de ajuda"
    puts "   * exit                                     - Encerra o jogo"
    puts "   * passar                                   - Passa a vez"
    puts "   * status                                   - Mostra informações do jogador e recursos"
    puts "   * map                                      - Exibe o mapa"
    puts "   * balancear [ID_CIDADE], [TROPAS], [TECNO] - Altera o balanceamento de tropas e tecnologia produzidas por uma cidade"
    puts "   * move [ID_FONTE], [N_SOLDADOS], [DIRECAO] - Move a quantidade de soldados de um local na direção definida. DIRECAO pode ser {NORTE, SUL, LESTE, OESTE}"
    puts ""
  end

  def passar
    @jogo.passar_a_vez
    clear()
  end

  def status
    puts "Tecnologia atual: #{@jogo.jogador_atual.tecnologia}"
    puts "Recursos:"
    @jogo.jogador_atual.cidades.each do |cidade|
      puts "  cidade##{cidade.id} ~> soldados: +#{cidade.g_exercito} | tecnologia: +#{cidade.g_tecnologia}"
    end
  end
  
  def map
    puts @jogo.mapa.to_s
  end

  def balancear id_cidade, tropas, tecnologia
    id_cidade = id_cidade.to_i
    tropas = tropas.to_i
    tecnologia = tecnologia.to_i

    begin
      @jogo.balancear_recursos id_cidade, tropas, tecnologia
    rescue CitygameException => e
      error_msg e.to_s
      return
    end

    success_msg "Quantidade de recursos produzidos alterada"
  end

  def move id_fonte, n_soldados, direcao
    id_fonte = id_fonte.to_i
    n_soldados = n_soldados.to_i
    direcao = @jogo.direcao direcao

    begin
      destino = @jogo.movimentar_tropas id_fonte, n_soldados, direcao
    rescue CitygameException => e
      error_msg e.to_s
      return
    end

    success_msg "Tropa movida para o local #{destino.id}"
  end

end
