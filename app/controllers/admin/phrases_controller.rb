class Admin::PhrasesController < ApplicationController
  
  before_filter :requires_login
  
  def index
    @phrases = Phrase.all
  end
  
  def edit
    @phrase = Phrase.find(params[:id])
  end
  
  def update
    @phrase = Phrase.find(params[:id])
    if @phrase.update_attributes(params[:phrase])
      redirect_to :action => "index" and return
    end
    render :action => "edit"
  end
  
  def new
  end
  
  def create
    @phrase = Phrase.new(params[:phrase])
    if @phrase.save
      redirect_to :action => "index" and return
    end
    render :action => "new"
  end
  
  def destroy
    @phrase = Phrase.find(params[:id])
    @phrase.destroy
    redirect_to :action => "index"
  end
  
end
