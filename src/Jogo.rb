# -*- encoding : utf-8 -*-
require_relative 'exceptions'
require_relative 'Jogador'
require_relative 'Cidade'
require_relative 'Digrafo'

class Jogo
  attr_reader :jogadores, :jogador_atual
  attr_reader :turno
  attr_reader :locais # Digrafo

  # Constantes
  LESTE = 3
  SUL = 6
  OESTE = 9
  NORTE = 12
  QUANTIDADE_DE_CIDADES = 5
  QUANTIDADE_DE_CAMPOS = 44

  def initialize
    @turno = 0
    @jogadores = []
    @locais = criar_locais
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

    @turno = 1
    @jogador_atual = @jogadores[rand(jogadores.size)]
  end

  # Passa a vez para o próximo jogador
  def passar_a_vez
    @jogador_atual.gerar_recursos()

    id_jogador_atual = @jogador_atual.id
    id_jogador_atual = id_jogador_atual + 1
    id_jogador_atual = 0 if id_jogador_atual >= @jogadores.size
    @jogador_atual = @jogadores[id_jogador_atual]
    @turno += 1
  end

  def balancear_recursos id_cidade, exercitos, tecnologia
    @jogador_atual.cidades.each do |cidade|
      if cidade.id == id_cidade then
        cidade.balancear_recursos exercitos, tecnologia
        return
      end
    end

    raise LocalException, 'Essa cidade não existe ou não lhe pertence'
  end

  # Movimenta tropa com n_soldados do jogador_atual, a tropa parte do local cujo id é
  # id_fonte e segue na direcao estabelecida um Local de distância
  def movimentar_tropas id_fonte, n_soldados, direcao

    if direcao!=LESTE and direcao!=SUL and direcao!=OESTE and direcao!=NORTE
      raise DirecaoException, 'Direção não pertence a {LESTE, SUL, OESTE, NORTE}'
    end

    for vertice in locais.vertices

      unless vertice.id == id_fonte and vertice.jogador == @jogador_atual
        raise LocalException, 'Essa cidade não existe ou não lhe pertence'
      end

      for tropa in vertice.tropas
        tropa_selecionada = tropa if tropa.jogador == @jogador_atual
      end

      unless 0 < n_soldados <= tropa_selecionada.tamanho
        raise NumeroDeExercitosException, 'Número de soldados inválido'
      end

      for sucessor in locais.sucessores(vertice)
        vertice_destino, d = sucessor.v, sucessor.peso
        sucesso = tropa_selecionada.movimentar(n_soldados, vertice_destino) if d == direcao
        return vertice_destino if sucesso
      end
      raise DirecaoException, 'Não existem locais nesta direção'
    end
  end

private

  # Cria todos os locais do jogo como um tabuleiro virtual quadrado
  # utilizando um digrafo G(V, A)
  # V = {v | v e um local}
  # A = {(v, w, p) | v, w pertencem a V tal que v é adjacente a w e
  #                  p pertence a {LESTE, SUL, OESTE, NORTE} tal que ele representa
  #                  a posicao de w em relacao a v}
  def criar_locais
    # Criar locais
    n_loc = QUANTIDADE_DE_CIDADES + QUANTIDADE_DE_CAMPOS
    raise LocalException, 'Não existem locais suficientes para iniciar o jogo' if (n_loc**(0.5))%(n_loc**(0.5)).floor != 0
    loc = Array.new(n_loc)
    for i in 0...QUANTIDADE_DE_CIDADES
      loc[i] = Cidade.new(i,true)
    end
    for i in 0...QUANTIDADE_DE_CAMPOS
      j = (QUANTIDADE_DE_CIDADES + i)
      loc[j] = Local.new(j,false)
    end

    # Misturar locais
    for i in 0...n_loc
      destino_randomico = rand(n_loc)
      loc[i], loc[destino_randomico] = loc[destino_randomico], loc[i]
    end

    # Criar grafo que representa os locais do jogo
    # Exemplo de mapa criado para auxiliar a criacao do grafo:
    #      local(04)--local(08)--local(10)-- ... --local(56)
    #         |          |           |                 |
    #      local(01)--local(03)--local(02)-- ... --local(34)
    #         |          |           |     ..           |
    #         :          :           :        ..        :
    #         |          |           |           ..     |
    #      local(07)--local(65)--local(79)-- ... --local(81)
    k = 0
    largura = n_loc**(0.5)
    comprimento = largura
    mapa = Array.new(comprimento) { |linha| linha = Array.new(largura) }
    grafo = Digrafo.new
    for i in 0...comprimento
      for j in 0...largura
        mapa[i][j] = loc[k]
        grafo.adicionar_vertice(mapa[i][j])
        unless (j-1) < 0
          grafo.conectar(mapa[i][j], mapa[i][j-1], OESTE)
          grafo.conectar(mapa[i][j-1], mapa[i][j], LESTE)
        end
        unless (i-1) < 0
          grafo.conectar(mapa[i][j], mapa[i-1][j], NORTE)
          grafo.conectar(mapa[i-1][j], mapa[i][j], SUL)
        end
        k = k + 1
      end
    end

    return grafo
  end

end
