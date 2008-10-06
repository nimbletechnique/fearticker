class Admin::PagesController < ApplicationController
  
  before_filter :requires_login
  
end
