
require 'PG'

# Classe para criar uma conexao ao banco
class Conexao

  def conecta
    @@conexao = PG.connect(
        :dbname => 'citygame_db',
        :user => '[postgre]',
        :password => '[]')
  end

  def desconecta
  	@@conexao.close
  end

end



