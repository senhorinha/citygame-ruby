class DAOUsuario

	 attr_reader :conexao

def initialize
	@conexao = Conexao.new
end

# Cadastra usuario na tabela usuarios
# @param [String] username
# @param [String] password
def cadastrar username,password
	if validar_campos username
		@conexao.conectar
		@conexao.prepare("cadastrar_usuario", "insert into usuarios (username, password) values ($1, $2)")
    	@conexao.exec_prepared("cadastrar_usuario", [username, password])
    	@conexao.desconectar
  end
end

# Procura usuario na tabela usuarios
# @param [String] username
# @param [String] password
# @return [Usuario] usuario
def procurar username, password
	@conexao.conectar
	@conexao.prepare("verificar_se_existe_usuario", "SELECT * FROM usuarios where username = ($1) and password = ($2)")
	resultado = @conexao.exec_prepared("verificar_se_existe_usuario",[username,password])
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
