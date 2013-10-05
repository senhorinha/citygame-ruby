# -*- encoding : utf-8 -*-
class Local
  attr_reader :id
  attr_reader :exercitos

  def initialize id
    @id = id
    @exercitos = []
  end

end
