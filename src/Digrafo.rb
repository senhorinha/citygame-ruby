# -*- encoding : utf-8 -*-

# Ruby < v1.9.3:
#require File.join(File.dirname(__FILE__), 'Aresta')
#require File.join(File.dirname(__FILE__), 'Grafo')

# Ruby >= v1.9.3:
require_relative 'Aresta'

# Exceção padrão da classe
class DigrafoException < Exception; end

# Usada para mapear a vizinhança de um grafo (sucessores e antecessores DIRETOS)
class Vizinhanca
  attr_accessor :suc, :ant
end

# Grafo orientado (Digrafo)
# Implementação usando lista de adjacência
# O grafo mantém um Hash que mapeia cada vértice 'v' para um objeto vizinhaça que possui dois atributos: suc - Um array de arestas dos vértices sucessores diretos de v; ant - Um array de arestas dos vértices antecessores diretos de v
class Digrafo
  attr_reader :vertices

  def initialize
    @vertices = Hash.new  # Guarda os vértices em um Hash. Hash é implementado internamente com um Hash Table, garantindo complexidades O(1) para as operações básicas (inserção, busca, deleção)
  end

  # Método que sobrescreve a impressão padrão de um objeto Digrafo
  def to_s
    r = super.to_s << "\n"
    @vertices.each do |vertice, vizinhanca|
      r <<= '|--- ' << vertice.to_s << ' => ['
      sucessores_s = vizinhanca.suc.map { |aresta| "(#{aresta.v}, #{aresta.peso})" }
      r <<= sucessores_s.join ', '
      r <<= ']'
      r <<= "\n"
    end

    return r
  end

  # Retorna um array com os vértices do digrafo
  # Complexidade: O(1)
  def vertices
    return @vertices.keys
  end

  # Retorna um vértice aleatório do digrafo ou nil se o digrafo está vazio
  # Complexidade: O(1)
  def um_vertice
    return nil if @vertices.empty?
    n = rand(0..(@vertices.size - 1))
    return @vertices.keys[n]
  end

  # Retorna a ordem do digrafo (número de vértices)
  # Complexidade: O(1)
  def ordem
    @vertices.size
  end

  # Retorna um Array contendo as arestas dos vértices sucessores a v1
  # Complexidade: O(1)
  # Parâmetros
  # => v1: vértice pesquisado
  def sucessores v1
    raise DigrafoException, 'O vértice não pertence ao grafo' unless @vertices.include? v1
    return @vertices[v1].suc
  end

  # Retorna um Array contendo as arestas dos vértices antecessores a v1
  # Complexidade: O(1)
  # Parâmetros
  # => v1: vértice pesquisado
  def antecessores v1
    raise DigrafoException, 'O vértice não pertence ao grafo' unless @vertices.include? v1
    return @vertices[v1].ant
  end

  # Adiciona um vértice ao digrafo
  # Complexidade: O(1)
  # Paramêtros:
  #   - v1: Vértice a ser adicionado
  def adicionar_vertice v1
    raise DigrafoException, 'O vértice já pertence ao grafo' if @vertices.include? v1

    @vertices[v1] = Vizinhanca.new
    @vertices[v1].suc = Array.new
    @vertices[v1].ant = Array.new
  end

  # Conecta o vértice v1 ao vértice v2
  # Complexidade: O(1)
  # Parâmetros:
  # => v1, v2: Vértices a serem conectados, sendo v1 o vértice de origem e v2 o vértice de destino
  # => peso: peso da aresta {default = 1}
  def conectar v1, v2, peso = 1
    raise DigrafoException, 'O vértice v1 não pertence ao grafo' unless @vertices.include? v1
    raise DigrafoException, 'O vértice v2 não pertence ao grafo' unless @vertices.include? v2

    @vertices[v1].suc.push Aresta.new(v2, peso)
    @vertices[v2].ant.push Aresta.new(v1, peso)
  end

  # Desconecta o vértice v1 do vértice v2
  # Importante: note que a chamada desconectar(v1, v2) é diferente de desconectar(v2, v1) (a chamada deve obedecer a direção da aresta existente)
  # Complexidade: O(g), onde g é o grau do vértice com o maior grau (entre os vértices desconectados)
  # Parâmetros
  # => v1, v2: Vértices a serem desconectados
  def desconectar v1, v2
    raise DigrafoException, 'O vértice v1 não pertence ao grafo' unless @vertices.include? v1
    raise DigrafoException, 'O vértice v2 não pertence ao grafo' unless @vertices.include? v2

    @vertices[v1].suc.delete_if { |aresta| aresta.v == v2 }
    @vertices[v2].ant.delete_if { |aresta| aresta.v == v1 }
  end

  # Remove um vértice do digrafo e todas as suas arestas relacionadas
  # Complexidade: ~O(g * G), onde g é o grau do vértice que está sendo removido e G é o grau máximo do grafo
  # Paramêtros:
  # => v1: Vértice a ser removido
  def remover_vertice v1
    raise DigrafoException, 'O vértice v1 não pertence ao grafo' unless @vertices.include? v1

    # Removendo arestas relacionadas
    @vertices[v1].suc.each { |aresta|
      @vertices[aresta.v].ant.delete_if { |ar| ar.v == v1 }
    }

    @vertices.delete v1
  end

  # Retorna o número de vértices sucessores a v
  # Complexidade: O(1)
  # Parâmetros
  # => v: Vértice a ser pesquisado
  def grau_emissao v
    return @vertices[v].suc.size
  end

  # Retorna o número de vértices antecessores a v
  # Complexidade: O(1)
  # Parâmetros
  # => v: Vértice a ser pesquisado
  def grau_recepcao v
    return @vertices[v].ant.size
  end

end
