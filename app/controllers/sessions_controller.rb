class SessionsController < ApplicationController
  
  def show
    redirect_to :action => "new"
  end
  
  def new
  end
  
  def create
    if params[:password] == "lovefear"
      session[:authenticated?] = true
      redirect_to dashboard_path and return
    end
    render :action => "new"
  end
  
  def destroy
    session.delete
    redirect_to dashboard_path and return
  end
  
end
