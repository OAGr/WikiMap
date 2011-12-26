module UsersHelper
  
  def card_pic(user)
    uid = user.authorizations.first.uid
    return "https://graph.facebook.com/#{uid}/picture"
  end
  
  def home_card(user)
    if user.cards.first.parent.name == "People"
      return user.cards.first
    else
      return user.cards.first
    end
  end
  
end
