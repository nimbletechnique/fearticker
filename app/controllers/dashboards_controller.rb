class DashboardsController < ApplicationController
  
  def show
    @pages = Page.ordered
  end
  
end
