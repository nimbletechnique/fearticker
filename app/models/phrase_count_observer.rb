class PhraseCountObserver < ActiveRecord::Observer
  
  def after_save(page_count)
    clear_cache(page_count)
  end
  
  def after_destroy(page_count)
    clear_cache(page_count)
  end
  
  private 
  
  def clear_cache(page_count)
    Page.expire(page_count.page_id)
  end
  
end