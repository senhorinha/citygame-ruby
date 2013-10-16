# -*- encoding : utf-8 -*-
require_relative 'exceptions'
require_relative 'Jogador'
require_relative 'Cidade'
require_relative 'Mapa'

class Jogo
  attr_reader :jogadores, :jogador_atual
  attr_reader :turno
  attr_reader :mapa

  def initialize
    @turno = 0
    @jogadores = []
    @mapa = Mapa.new
  end

  # Cria um novo jogador
  # Parâmetros: nome (String) -> nome do novo jogador
  # Jogadores devem ser criados antes da partida iniciar. Caso novos jogadores tentem ser criados após a partida iniciar, o método lança um CitygameException
  def criar_jogador nome
    raise NovoJogadorException, 'Impossível criar novos jogadores no meio de uma partida!' if @turno != 0

    jogador = Jogador.new @jogadores.size, nome
    @jogadores.push jogador
  end

  # Inicia a partida, passando a vez para o primeiro jogador
  def iniciar
    raise MinimoDeJogadoresException, 'Pelo menos dois jogadores devem existir para uma partida acontecer!' if @jogadores.size < 2

    @mapa.criar_locais

    @jogadores.each do |jogador|
      @mapa.atribuir_cidade_ao_jogador jogador
    end

    @turno = 1
    @jogador_atual = @jogadores[rand(jogadores.size)]
  end

  # Passa a vez para o próximo jogador
  def passar_a_vez
    @jogador_atual.gerar_recursos()
    @jogador_atual.executar_atividades(@turno)

    id_jogador_atual = @jogador_atual.id
    id_jogador_atual = id_jogador_atual + 1
    id_jogador_atual = 0 if id_jogador_atual >= @jogadores.size
    @jogador_atual = @jogadores[id_jogador_atual]
    @turno += 1
  end

  def balancear_recursos id_cidade, tropas, tecnologia
    @jogador_atual.cidades.each do |cidade|
      if cidade.id == id_cidade
        cidade.balancear_recursos tropas, tecnologia
        return
      end
    end

    raise LocalException, 'Essa cidade não existe ou não lhe pertence'
  end

  # Movimenta tropa com n_soldados do jogador_atual, a tropa parte do local cujo id é
  # id_fonte e segue na direcao estabelecida um Local de distância
  def movimentar_tropas id_fonte, n_soldados, direcao
    raise DirecaoException, "Direção não pertence a {LESTE, SUL, OESTE, NORTE}" unless @mapa.direcao_valida? direcao

    fonte = @mapa.get_local_by_id id_fonte
    raise LocalException, "Este local não existe" if fonte.nil?

    tropa = fonte.get_tropa_jogador @jogador_atual
    raise LocalException, "Não existem tropas suas neste local" if tropa.nil?

    destino = @mapa.get_local_adjacente fonte, direcao
    raise DirecaoException, "Não existem locais nesta direção" if destino.nil?

    result = tropa.movimentar(n_soldados, destino)
    raise SemStaminaException, "A tropa está cansada por já ter se movido neste turno" unless result

    return destino
  end

  # Recebe uma string {NORTE, SUL, LESTE, OESTE} e retorna um inteiro que representa a direção informada
  # @param [String] Um dentre {NORTE, SUL, LESTE, OESTE}
  # @return [Integer] Int que representa a direção ou nil em caso de direção não reconhecida
  def direcao str_dir
    return @mapa.str_direcao str_dir
  end

end
