module CardsHelper
  
  def div_for_level(level)
    "span#{12-level.to_i*4} card-children"
  end
  
  def find_level(card, original)
    x = 0
    while card != original
      card = card.parent
      x += 1
    end
    return x
    
  end
  
  def render_screen(card, original)
      level = find_level(card, original)
      if level < 4
        render(:partial => '/cards/card', :locals => { :card => card, :original => original })
      end
  end

end
