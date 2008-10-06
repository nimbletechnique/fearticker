class PhraseCount < ActiveRecord::Base

  named_scope :for_phrase, lambda { |phrase| { :include => :phrase, :conditions => ["phrases.text = ?", phrase]}}
  named_scope :in_range, lambda { |from, to| { :conditions => ["phrase_counts.created_at >= ? and phrase_counts.created_at <= ?", from, to]}}
  
  belongs_to :page
  belongs_to :phrase
  
  validates_presence_of :page
  validates_presence_of :phrase
  
end
