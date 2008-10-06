class PhraseCount < ActiveRecord::Base
  
  validates_presence_of :page
  validates_presence_of :phrase
  
end
