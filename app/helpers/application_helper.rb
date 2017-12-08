module ApplicationHelper
  def is_active?(page_name)
    if params[:action] == page_name
      "active-nav"
    end
  end
end
