# -*- encoding : utf-8 -*-

require_relative 'Persistence'
require_relative '../LogBatalha'
require_relative '../Usuario'

class DAOLogBatalha
	include Persistence

	# Cadastra usuario na tabela usuarios
	# @param [LogBatalha] log_batalha
	def create log_batalha
		vencedor_username = log_batalha.vencedor.username
		turnos = log_batalha.turnos
		id = gerador_de_id
		CONNECTION.exec( "INSERT INTO batalhas (id,turnos, vencedor) values (#{id}, #{turnos}, '#{vencedor_username}')" )
	end

	# Procura usuario na tabela usuarios
	# @param [Usuario] usuario
	# @return [LogBatalha[]] batalhas
	def read_batalhas_vencidas_por usuario
		
		username = usuario.username
		query_batalhas = CONNECTION.exec( "SELECT * FROM batalhas where vencedor = '#{username}'" )
		
		batalhas = []
		query_batalhas.each do |resultado_tabela_batalhas|
			jogadores = []
			query_username_jogadores = CONNECTION.exec( "SELECT username FROM batalha_usuarios where batalha_id = #{resultado_tabela_batalhas['id']}" )
			query_username_jogadores.each do |resultado_tabela_batalha_usuarios|
				query_password = CONNECTION.exec( "SELECT password FROM usuarios where username = '#{resultado_tabela_batalha_usuarios['username']}' " )
					query_password do |resultado_tabela_usuarios|
						jogadores.push (Usuario.new resultado_tabela_batalha_usuarios['username'], resultado_tabela_usuarios['password'])
					end
					query_password.clear
			end

			
			batalha = LogBatalha.new
			batalha.jogadores = jogadores
			batalha.turnos = resultado_tabela_batalhas["turnos"].to_i
			batalha.vencedor = usuario

			batalhas.push batalha
			
			query_username_jogadores.clear
		end
		query_batalhas.clear
		return batalhas
	end

	private

	# @return [Fixnum] id
	def gerador_de_id
		id = 0

		result = CONNECTION.exec( "SELECT max(id) FROM batalhas" )
		result.each do |row|
			id = row['max'].to_i
		end
		result.clear
		return (id + 1)
	end


end
