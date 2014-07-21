module UsersHelper
  def logged?
  	puts session[:id] 
  	session[:id]
  end
end
