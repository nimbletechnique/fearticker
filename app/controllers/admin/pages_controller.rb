class Admin::PagesController < ApplicationController
  
  before_filter :requires_login
  
  def index
    @pages = Page.all
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to :action => "index" and return
    end
    render :action => "edit"
  end
  
  def new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to :action => "index" and return
    end
    render :action => "new"
  end
  
  def destroy
  end
  
end
