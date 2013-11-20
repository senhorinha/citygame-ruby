# -*- encoding : utf-8 -*-

require_relative 'Persistence'

class DAOLogBatalha
	include Persistence

	@@id = 0

	# Cadastra usuario na tabela usuarios
	# @param [LogBatalha] log_batalha
	def create log_batalha
		vencedor_username = log_batalha.vencedor.username
		turnos = log_batalha.turnos
	   CONNECTION.exec( "INSERT INTO batalhas (id,turnos, vencedor) values ('#{@@id}','#{turnos}', '#{vencedor_username}')" )
	   id += 1;
	end

	# Procura usuario na tabela usuarios
	# @param [Usuario] usuario
	# @return [LogBatalha[]] batalhas
	def read_batalhas_vencidas_por usuario
		
		username = usuario.username
		query_batalhas = CONNECTION.exec( "SELECT * FROM batalhas where vencedor = '#{username}'" )
		
		batalhas = []
		query_batalhas.each do |row_batalhas|
			jogadores = []
			query_username_jogadores = CONNECTION.exec( "SELECT username FROM batalha_usuario where batalha_id = '#{row_batalhas[0]}'" )
			query_username_jogadores do |row_username|
				query_password = CONNECTION.exec( "SELECT password FROM usuarios where username = '#{row_username[0]}' " )
					query_password do |row_password|
						jogadores.push (Usuario.new row_username[0], row_password[0])
					end
					query_password.clear
			end
			query_username_jogadores.clear
			batalhas.push (LogBatalha.new jogadores, row_batalhas[1], usuario)
		end
		query_batalhas.clear
		return batalhas
	end

end
