class Admin::ContentsController < ApplicationController
  
  before_filter :requires_login
  before_filter :load_content
  
  def index
    @contents = Content.ordered
  end
  
  def new
  end
  
  def create
    @content = Content.new(params[:content])
    if @content.save
      flash[:notice] = "Content saved"
      redirect_to admin_contents_path and return
    end
    render :action => "new"
  end
  
  def edit
  end
  
  def update
    if @content.update_attributes(params[:content])
      flash[:notice] = "Content updated"
      redirect_to admin_contents_path and return
    end
    render :action => "edit"
  end
  
  def show
  end
  
  def destroy
    @content.destroy
    flash[:notice] = "Content destroyed"
    redirect_to admin_contents_path
  end

  private
  
  def load_content
    @content = Content.find(params[:id]) if params[:id]
  end

end