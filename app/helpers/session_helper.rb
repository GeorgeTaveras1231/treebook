module SessionHelper
  def signed_in?
    current_user ? true : false
  end
end