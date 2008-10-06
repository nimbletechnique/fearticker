class Admin::ResetsController < ApplicationController
  
  def create
    PhraseCount.destroy_all
    redirect_to root_path
  end
  
end
