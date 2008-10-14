class PhraseCount < ActiveRecord::Base

  named_scope :for_phrase, lambda { |phrase| { :include => :phrase, :conditions => ["phrases.text = ?", phrase]}}
  named_scope :in_range, lambda { |from, to| { :conditions => ["phrase_counts.created_at >= ? and phrase_counts.created_at <= ?", from, to]}}
  named_scope :ordered, :order => "phrase_counts.created_at DESC"
  named_scope :including_phrases, :include => :phrase
  named_scope :limited_to, lambda { |limit| { :limit => limit }}
  
  belongs_to :page
  belongs_to :phrase
  
  validates_presence_of :page
  validates_presence_of :phrase
  
end
