# -*- encoding : utf-8 -*-

require_relative 'exceptions'
require_relative 'Digrafo'

class Mapa
  attr_reader :campos, :cidades, :matriz, :grafo

  # Constantes
  LESTE = 3
  SUL = 6
  OESTE = 9
  NORTE = 12
  QUANTIDADE_DE_CIDADES = 5
  QUANTIDADE_DE_CAMPOS = 44

  # Cria um novo mapa aleatório
  def initialize
    @campos = []
    @cidades = []
    @matriz = [[]]
  end

  # Checa se o id da direção é uma direção válida
  # @param [Integer] Constante que representa uma direção
  # @return [Boolean]
  def direcao_valida? direcao_const
    direcao_const == LESTE or direcao_const == SUL or direcao_const == OESTE or direcao_const == NORTE
  end

  # Recebe uma string {NORTE, SUL, LESTE, OESTE} e retorna um inteiro que representa a direção informada
  # @param [String] Um dentre {NORTE, SUL, LESTE, OESTE}
  # @return [Integer] Int que representa a direção ou nil em caso de direção não reconhecida
  def str_direcao str_dir
    direcao = nil

    case str_dir.upcase
      when 'NORTE'
        direcao = NORTE
      when 'SUL'
        direcao = SUL
      when 'LESTE'
        direcao = LESTE
      when 'OESTE'
        direcao = OESTE
    end

    return direcao
  end

  def criar_locais
    # Criar locais
    n_loc = QUANTIDADE_DE_CIDADES + QUANTIDADE_DE_CAMPOS
    raise LocalException, 'Não existem locais suficientes para iniciar o jogo' if (n_loc**(0.5))%(n_loc**(0.5)).floor != 0
    loc = Array.new(n_loc)
    for i in 0...QUANTIDADE_DE_CIDADES
      loc[i] = Cidade.new(i,true)
      @cidades.push loc[i]
    end
    for i in 0...QUANTIDADE_DE_CAMPOS
      j = (QUANTIDADE_DE_CIDADES + i)
      loc[j] = Local.new(j,false)
      @campos.push loc[j]
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

    @matriz = mapa
    @grafo = grafo
  end

  # Atribui uma cidade aleatório do mapa ao jogador
  # @param [Jogador]
  def atribuir_cidade_ao_jogador jogador
    begin
      rand_city = @cidades[rand(@cidades.size)]
    end while (!rand_city.abandonada?) # Se a cidade já foi atribuída a alguém, atribui outra cidade

    jogador.atribuir_cidade rand_city
  end

end
