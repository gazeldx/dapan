class Admin::BaseController < ApplicationController

  layout '/layouts/admin/application'
  before_filter :admin

  
end
