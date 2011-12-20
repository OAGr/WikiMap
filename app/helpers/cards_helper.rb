module CardsHelper
  
  def div_for_level(level)
    "span#{16-level.to_i*4} card-children"
  end

  
  def render_card_tree(root_card, level)
    if level < 4
      content_tag_for(:div, root_card, :class => "row ") do
        
          render_string = ""
          render_string << render(:partial => '/cards/card', :locals => {:card => root_card})
          render_string << "<div class='#{div_for_level(level+1)}'>"
            root_card.children.each do |c|
              render_string << render_card_tree(c, level+1)
            end
          render_string << "</div>"
          render_string.html_safe
      end
    else
      ""
    end  
  end
  
  def render_new_card(card)
    content_tag_for(:div, card, :class => "row ") do
      render_string = ""
      render_string <<render(:partial => '/cards/card', :locals => {:card => card})
      render_string << "<div class='card-children' ></div>"
      render_string.html_safe
    end
  end

  def grandparent_ID(card)
    grandparent = has_parent(card, 3)
    if (grandparent == false)
      return 1
    else
      return grandparent.id
    end
  end
  
  def great_grandparent(card)
    return has_parent(card, 4)
  end
  
  def has_parent(card,level)
    if level == 0
      return card
    elsif !card.parent.nil?
      level = level - 1
      return has_parent(card.parent,level)
    else
      return false
    end
  end
end
