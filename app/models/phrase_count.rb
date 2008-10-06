class PhraseCount < ActiveRecord::Base
  
  belongs_to :page
  belongs_to :phrase
  
  validates_presence_of :page
  validates_presence_of :phrase
  
end
