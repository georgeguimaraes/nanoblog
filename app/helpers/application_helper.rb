# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def show_flash_messages
    if flash[:notice]
      "<p style=\"color: green\">#{flash[:notice]}</p>"
    elsif flash[:error]
      "<p style=\"color: red\">#{flash[:error]}</p>" 
    end
  end

end
