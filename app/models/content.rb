class Content < ActiveRecord::Base
  
  validates_presence_of :permalink
  validates_presence_of :body
  validates_uniqueness_of :permalink
  
  named_scope :ordered, :order => :permalink
  
end
