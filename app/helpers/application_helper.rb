module ApplicationHelper
  include Pagy::Frontend

  def current_class?(test_path)
    request.path == test_path ? 'nav-link active' : ''
  end

end
