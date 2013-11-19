# -*- encoding : utf-8 -*-

require_relative 'Conexao'

class DAOUsuario
	attr_reader :conexao

	def initialize
		@conexao = Conexao.new
	end

	# Cadastra usuario na tabela usuarios
	# @param [String] username
	# @param [String] password
	def create username,password
		@conexao.conectar
		if validar_campos username
			@conexao.prepare("create", "insert into usuarios (username, password) values ($1, $2)")
	    	@conexao.exec_prepared("create", [username, password])
	  	end
	  	@conexao.desconectar
	end

	# Procura usuario na tabela usuarios
	# @param [String] username
	# @param [String] password
	# @return [Usuario] usuario
	def read username, password
		@conexao.conectar
		@conexao.prepare("read", "SELECT * FROM usuarios where username = ($1) and password = ($2)")
		resultado = @conexao.exec_prepared("read",[username,password])
		conexao.desconectar
		unless resultado.empty?
			return Usuario.new username,password
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
		@conexao.prepare("buscar_pelo_username", "SELECT * FROM usuarios where username = ($1)")
		resultado = @conexao.exec_prepared("buscar_pelo_username",[username])
		resultado.empty?
	end

end
