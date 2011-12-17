class Authorization < ActiveRecord::Base
  belongs_to :user
  
  def find_from_hash(hash)
    find_by_provider_and_uid(hash[:provider], hash[:uid])
  end
  
  def create_from_hash(hash, user)
    @auth = self.new(:user_id => user.id, :provider => hash[:provider], :uid => hash[:uid], :token => hash[:credentials][:token])
    if @auth.save
      @auth
    elsif
    return false
    end
  end

end

