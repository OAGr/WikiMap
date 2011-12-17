module CardsHelper
  
  def div_for_level(level)
    "span#{16-level.to_i*4} card-children"
  end

  
  def render_card_tree(root_card, level)
    if level < 4
      content_tag :div, :class => "row" do 
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
  

end
