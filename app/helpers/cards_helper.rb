module CardsHelper
  
  def div_for_level(level)
    "span#{16-level.to_i*3} card-children"
  end

  def left_arrow(card)
    arrow = ""
    if !card.parent.nil?   
      a = link_to(image_tag("/left-arrow.png", :width => '22px' ), card_path(card.parent.parent))
    end
      "<div class='span1 arrow leftpoint'> #{a} </div>"
  end
  
  def right_arrow(card)
    arrow = ""
    if !card.children.empty?   
      a = link_to(image_tag("/right-arrow.png", :width => '22px' ), card_path(card))
    end
      "<div class='span1 arrow rightpoint'> #{a} </div>"
  end
    
  def render_card_tree(root_card, level)
    if level < 5
      content_tag_for(:div, root_card, :class => "row #{ !root_card.parent.nil?}") do
        
          render_string = ""
          
          if (level == 0) then render_string << left_arrow(root_card) end
          
          render_string << render(:partial => '/cards/card', :locals => {:card => root_card})
          render_string << "<div class='#{div_for_level(level+1)} '>"
          
            root_card.children.each do |c|
              render_string << render_card_tree(c, level+1)
            end
            
          render_string << "</div>"
          
            
          render_string.html_safe
      end
    else
     right_arrow(root_card) 
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
    list = [card]
    #unshifts add to beginning of list
    list.unshift list.first.parent until list.first.parent.nil?
    list.unshift  until list.first.parent.nil? 
    list.map{|c| link_to(c.name, c)}.join(" / ").html_safe
  end
  

end
