class BlogsController < ApplicationController
  def create
    @blog = Blog.new(content: params[:content])
    if @blog.save
      redirect_to root_path, notice: "您好，Blog posted!"
    else
      redirect_to root_path, notice: "您好，Blog not posted!"
    end
  end
end
