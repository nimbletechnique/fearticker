class Admin::ResetsController < ApplicationController
  
  before_filter :requires_login
  
  def create
    PhraseCount.destroy_all
    redirect_to root_path
  end
  
end
