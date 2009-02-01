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
  
  # Método que recebe um hash com os valores de e-mail e password, procura
  # o dado e-mail no banco e o autentica, caso o password sejá válido.
  #
  # Retorna o usuário encontrado ou nil.
  #
  def self.find_and_authenticate(options)
    return nil if options[:email].blank? || options[:password].blank?

    user = User.find_by_email(options[:email])
    
    if user
      user.authenticate(options[:password]) ? user : nil
    else
      return nil
    end
  end

  # Método de autenticação que recebe o password e o encripta comparando
  # com o password criptogragado no banco de dados. Retorna true ou false.
  #
  def authenticate(auth_password)
    User.encrypt(auth_password, self.salt) == self.hashed_password
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
