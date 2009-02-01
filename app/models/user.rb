require 'digest/sha1'

class User < ActiveRecord::Base
  validates_confirmation_of :email, :password
  validates_presence_of :email
  
  def password
    @password || ''
  end
  
  # Método para setar o password.
  # Ele automaticamente gera o salt e encripta o password enviado.
  #
  def password=(new_password)
    @password = new_password
    return nil if @password.blank?

    self.salt            = User.random_string(10)
    self.hashed_password = User.encrypt(@password, self.salt)
  end
  
  protected
    # Método que recebe um password e um salt e retorna o password criptografado com SHA1.
    #
    def self.encrypt(password, salt)
      return nil if password.blank? || salt.blank?
      Digest::SHA1.hexdigest(password + 'nanoblog' + salt)
    end

    # Método que gera uma string aleatória com o tamanho enviado.
    # Atualmente usado para gerar o salt, confirmation_code e reset_password_code.
    #
    def self.random_string(length)
      chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a

      newpass = ''
      1.upto(length) { |i| newpass << chars.rand }

      return newpass
    end

end