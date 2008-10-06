class Admin::UpdatesController < ApplicationController
  
  def create
    Page.count_all
    redirect_to root_path
  end
  
end
