class Phrase < ActiveRecord::Base

  named_scope :all, {}
  named_scope :for_page, lambda { |page| {:include => :pages, :conditions => ["pages.id=?", page.id]}}
  
  has_many :phrase_counts, :dependent => :destroy
  has_many :pages, :through => :phrase_counts
  validates_uniqueness_of :text
  
end
