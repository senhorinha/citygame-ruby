# -*- encoding : utf-8 -*-

require_relative 'Persistence'

class DAOUsuario
	include Persistence

	# Cadastra usuario na tabela usuarios
	# @param [Usuario] username
	def create usuario
		username = usuario.username
		password = usuario.password
	    @conn.exec( "INSERT INTO usuarios (username, password) values (#{username}, #{password})" )
	  end
	end

	# Procura usuario na tabela usuarios
	# @param [String] username
	# @param [String] password
	# @return [Usuario] usuario
	def read username, password
		CONNECTION.prepare("read", "SELECT * FROM usuarios where username = ($1) and password = ($2)")
		resultado = CONNECTION.exec_prepared("read", [username,password])
		unless resultado.values.empty?
			return Usuario.new username, password, password
		end
		#TODO: Avisar usuário? Lançar excpetion?
	end

private

	# Faz a validação do campo username (Não permite cadastrar username já existente)
	# @param [String] username
	def validar_campos username
		return existe_usuario_com_username? username
	end

	# Procura se existe usuario com username no banco de dados.
	# @param [String] username
	def existe_usuario_com_username? username
		CONNECTION.prepare("buscar_pelo_username", "SELECT * FROM usuarios where username = ($1)")
		resultado = CONNECTION.exec_prepared("buscar_pelo_username", [username])
		resultado.values.empty?
	end

end
