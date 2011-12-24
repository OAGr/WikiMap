module CardsHelper
  
  def div_for_level(level)
    "span#{20-level.to_i*4} card-children"
  end

  def render_card_tree(root_card, level)
    if level < 5
      content_tag_for(:div, root_card, :class => "row #{ !root_card.parent.nil?}") do
        
          render_string = ""
          render_string << render(:partial => '/cards/card', :locals => {:card => root_card})
          render_string << "<div class='#{div_for_level(level+1)} '>"
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
      render_string << render(:partial => '/cards/card', :locals => {:card => card})
      render_string << "<div class='card-children' ></div>"
      render_string.html_safe
    end
  end

  def grandparent_ID(card)
    grandparent = has_parent(card, 4)
    if (grandparent == false)
      return 1
    else
      return grandparent.id
    end
  end
  
  def great_grandparent(card)
    return has_parent(card, 5)
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
  
  def parent_card_list(card)
    parent_list = []
    while (card.parent != nil) and (parent_list.length < 3) do
      parent = card.parent
      parent_list.push(parent) 
      card = parent
      puts card
    end
    output = ""
    parent_list = parent_list.reverse
    parent_list.each do |card|
      cardName = truncate( card.name, :length => 25, :separator => ' ') 
      output <<  '<li>' + link_to(cardName, card) + '<span class="divider">/</span></li>'
    end
    return output.html_safe
  end
  

end
