class PagesController < ApplicationController

  caches_page :show
  
  def show
    @page = Page.find(params[:id])
  end
  
end