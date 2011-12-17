module CardsHelper
  
  def div_for_level(level)
    "span#{16-level.to_i*4} card-children"
  end
  
  def find_level(card, original)
    x = 0
    while card != original
      card = card.parent
      x += 1
    end
    return x
    
  end
  
  def render_card_tree(root_card, level)
    if level < 4
      content_tag :div, :class => div_for_level(level) do
        content_tag :div, :class => "row" do 
          render_string = ""
          render_string << render(:partial => '/cards/card', :locals => {:card => root_card})
          root_card.children.each do |c|
            render_string << render_card_tree(c, level+1)
          end
          render_string.html_safe
        end
      end
    else
      ""
    end  
  end
  
  
  def render_screen(card, original)
      level = find_level(card, original)
      if level < 4
        render(:partial => '/cards/card', :locals => { :card => card, :original => original })
      end
  end
  
end
