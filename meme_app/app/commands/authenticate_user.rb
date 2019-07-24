class AuthenticateUser
    prepend SimpleCommand

    def initialize(email, password)
        @email = email
        @password = password
    end

    def call
        @resp_hash = Hash.new
        @resp_hash[:token] = JsonWebToken.encode(user_id: user.id) if user
        @resp_hash[:user_info] = user
        return @resp_hash
    end

    # def user_info 
    #     user = User.find_by_email(email)
    #     return user
    # end

    private

    attr_accessor :email, :password
    
    def user
        user = User.find_by_email(email)
        return user if user && user.authenticate(password)
        errors.add :user_authentication, 'invalid credentials'
        nil
    end
end