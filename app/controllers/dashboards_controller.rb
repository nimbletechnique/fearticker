class DashboardsController < ApplicationController
  
  def show
    @pages = Page.all.ordered
  end
  
end
