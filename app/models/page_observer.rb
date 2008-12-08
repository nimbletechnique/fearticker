class PageObserver < ActiveRecord::Observer
  
  def after_save(page)
    clear_cache(page)
  end
  
  def after_destroy(page)
    clear_cache(page)
  end
  
  private 
  
  def clear_cache(page)
    Page.expire(page.id)
  end
  
end