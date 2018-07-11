module ApplicationHelper
  def set_title page_title
    base_title = t "base_title"
    page_title ? base_title : page_title + " | " + base_title
  end
end
