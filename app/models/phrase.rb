class Phrase < ActiveRecord::Base

  named_scope :all, {}
  
  has_many :phrase_counts, :dependent => :destroy
  validates_uniqueness_of :text
  
end
