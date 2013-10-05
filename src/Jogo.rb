# -*- encoding : utf-8 -*-
require_relative 'CitygameException'
require_relative 'Jogador'
require_relative 'Cidade'

class Jogo
  attr_reader :jogadores, :jogador_atual
  attr_reader :turno
  attr_reader :locais

  def initialize
    @turno = 0
    @jogadores = []
    @locais = []
  end

  # Cria um novo jogador
  # Parâmetros: nome (String) -> nome do novo jogador
  # Jogadores devem ser criados antes da partida iniciar. Caso novos jogadores tentem ser criados após a partida iniciar, o método lança um CitygameException
  def criar_jogador nome
    raise CitygameException, "Impossível criar novos jogadores em no meio de uma partida!" if @turno != 0

    jogador = Jogador.new @jogadores.size, nome
    @jogadores.push jogador
  end

  # Inicia a partida, passando a vez para o primeiro jogador
  def iniciar
    raise CitygameException, "Pelo menos dois jogadores devem existir para uma partida acontecer!" if @jogadores.size < 2

    @turno = 1
    @jogador_atual = @jogadores[0] # TODO: deixar aleatório
    criar_locais()
  end

  # Passa a vez para o próximo jogador
  def passar_a_vez
    @jogador_atual.gerar_recursos()
    # TODO movimentar tropas

    id_jogador_atual = @jogador_atual.id
    id_jogador_atual = id_jogador_atual + 1
    id_jogador_atual = 0 if id_jogador_atual >= @jogadores.size
    @jogador_atual == @jogadores[id_jogador_atual]
  end

  def balancear_recursos id_cidade, exercitos, tecnologia
    @jogador_atual.cidades.each do |cidade|
      if cidade.id == id_cidade then
        cidade.balancear_recursos exercitos, tecnologia
        return
      end
    end

    raise CitygameException, "Essa cidade não existe ou não lhe pertence"
  end

  def movimentar_tropas id_fonte, id_destino, n_soldados

    # TODO: gerar movimento com:
    # tropa_de_um_local.movimentar n_soldados, local_destino

    #raise CitygameException, "Essa cidade não existe ou não lhe pertence"
  end

private

  def criar_locais
    # TODO: usar grafos
  end

end
