class User < ActiveRecord::Base
  has_many :authorizations
  has_many :cards
  
  
  after_create do |user|
      a = Card.new
        a.name = user.name
        a.description = "Edit this card to add a bio!"
        a.parent = Card.where(:name => "People")[0]
      a.save
  end
  
  
  def self.new_from_hash(hash)
    user = User.new(:name => hash[:info][:name], :email => hash[:info][:email])
    if user.save
      return user
    else
      retun false
    end
  end

end
