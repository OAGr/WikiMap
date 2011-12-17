class User < ActiveRecord::Base
  has_many :authorizations
  has_many :cards
  
  def new_from_hash(hash)
    user = new(:name => hash[:info][:name], :email => hash[:info][:email])
    if user.save
      return user
    else
      retun false
    end
  end

end
