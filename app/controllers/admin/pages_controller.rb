class Admin::PagesController < ApplicationController
  
  before_filter :requires_login
  
  def index
    @pages = Page.ordered
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
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to :action => "index"
  end

  def sort
    respond_to do |format|
      params[:pagelist].each do |id|
        Page.find(id).update_attribute :position, params[:pagelist].index(id)
      end
      format.js do
        render :update do |page|
          page[:pagelist].highlight
        end
      end
    end
  end
  
end
