class PagesController < ApplicationController
  
  def show
    page = Page.find(params[:id])
    render :xml => page.to_xml
  end
  
end