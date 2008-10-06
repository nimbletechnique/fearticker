class Phrase < ActiveRecord::Base

  named_scope :all, {}
  
  has_many :phrase_counts
  validates_uniqueness_of :text
  
end
