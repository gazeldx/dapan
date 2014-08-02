module UsersHelper
  def logged?
  	session[:id]
  end
end
