require 'pg'

# Classe para criar uma conexao ao banco
class Conexao

  def conectar
    @@conexao = PG.connect(
        :dbname => 'citygame_db',
        :user => '[postgres]',
        :password => '[]')
  end

  def desconectar
  	@@conexao.close
  end

end



