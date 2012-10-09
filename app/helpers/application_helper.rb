module ApplicationHelper
  
  def title(value)
    content_for(:title, value)
    return true
  end
  
end
