class Phrase < ActiveRecord::Base
  
  has_many :phrase_counts
  validates_uniqueness_of :text
  
end
