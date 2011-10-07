module ApplicationHelper
  
  def flash_helper
    
    if flash[:notice] 
      x = content_tag(:div, flash[:notice], :class => "notice")
      content_tag(:div, x, :class => "flash")
    end
    
    if flash[:alert]
      x = content_tag(:div, flash[:alert], :class => "alert")
      content_tag(:div, x, :class => "flash")
    end
    
  end

end
