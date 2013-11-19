# -*- encoding : utf-8 -*-

require 'digest'
require_relative 'LogBatalha'

class Usuario
  attr_reader :username, :password
  attr_reader :batalhas

  def initialize username, password, password_confirm
    raise ArgumentError, "Nome de usuário deve conter 3-30 caraceres (somente letras, números e _)" unless Usuario.valid_username?(username)
    @username = username

    raise ArgumentError, "Senha deve conter 4-30 caracteres" unless Usuario.valid_password?(password)
    raise ArgumentError, "A senha e sua confirmação não são idênticas" unless password == password_confirm

    @password = Usuario.digest password
  end

  def self.valid_username? username
    !username.match(/^[a-zA-Z0-9_]{3,30}$/).nil?
  end

  def self.valid_password? password
    !password.match(/^.{4,30}$/).nil?
  end

  def self.digest password
    Digest::SHA1.hexdigest(password)
  end

end
