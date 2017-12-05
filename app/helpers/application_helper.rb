module ApplicationHelper
  
  def current_url
    url_for :only_path=>true
  end

  def is_active?(page_name)
  "active" if params[:action] == page_name
  end
end
