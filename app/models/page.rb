class Page < ActiveRecord::Base
  
  has_many :phrase_counts
  has_many :phrases, :through => :phrase_counts
  
end
