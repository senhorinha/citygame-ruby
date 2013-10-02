class CommandParser

  def parse string
    pieces = string.split ' ', 2
    command = pieces[0].downcase

    if pieces[1] then
      options = pieces[1].split ','
    else
      options = []
    end

    options = options.map { |opt| opt.strip }

    return {
      :command => command,
      :options => options
    }
  end

end
