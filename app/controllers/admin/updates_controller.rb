class Admin::UpdatesController < ApplicationController
  
  before_filter :requires_login
  
  def create
    Page.count_all
    redirect_to root_path
  end
  
end
