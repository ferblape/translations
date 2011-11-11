# coding: UTF-8

module ApplicationHelper

  def flash_helper
    if flash[:notice]
      x = content_tag(:div, flash[:notice], :class => "notice")
      return content_tag(:div, x, :class => "flash")
    end
    if flash[:alert]
      x = content_tag(:div, flash[:alert], :class => "alert")
      return content_tag(:div, x, :class => "flash")
    end
  end

end
