# -*- encoding : utf-8 -*-
require_relative 'CitygameException'
require_relative 'Local'

class Cidade < Local
  attr_reader :id, :g_exercito, :g_tecnologia
  attr_reader :jogador
  attr_reader :status

  STATUS_PROTEGIDA  = 1
  STATUS_SOB_ATAQUE = 2
  STATUS_SOB_CERCO  = 3

  def initialize id
    @id = id
    @g_exercito = 10
    @g_tecnologia = 0
    @jogador = nil
    @status = STATUS_PROTEGIDA
  end

  # Balanceia os recursos gerados pela cidade
  # Parâmetros: tropas (inteiro), tecnologia (inteiro)
  # A soma de tropas e tecnologia não deve ultrapassar 10. Se isso acontecer, um CitygameException é lançado
  def balancear_recursos exercitos, tecnologia
    raise CitygameException, "A soma dos exercitos e tecnologia não deve ser maior que 10" if exercitos + tecnologia > 10

    @g_exercito = exercitos
    @g_tecnologia = tecnologia
  end

  def gerar_exercitos
    @exercitos.push Exercito.new(@jogador, @g_exercito) if @status != STATUS_SOB_CERCO && @jogador != nil
    # TODO: mesclar exercitos?
  end

  def taxa_tecnologia
    @g_tecnologia if @status != STATUS_SOB_CERCO && @jogador != nil
  end

end
