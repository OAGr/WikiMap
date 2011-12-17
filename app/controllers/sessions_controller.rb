class SessionsController < ApplicationController
  def create
    @auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
      #store token if its new
      #create new user
      new_user = User.new_from_hash(hash)
       @auth = Authorization.create_from_hash(auth, new_user)
     end
     # Log the authorizing user in.
     self.current_user = @auth.user
  end
  

end