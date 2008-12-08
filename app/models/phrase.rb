# == Schema Information
# Schema version: 20081014141701
#
# Table name: phrases
#
#  id         :integer         not null, primary key
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Phrase < ActiveRecord::Base

  named_scope :all, {}
  named_scope :for_page, lambda { |page| {:include => :pages, :conditions => ["pages.id=?", page.id]}}
  
  has_many :phrase_counts, :dependent => :destroy
  has_many :pages, :through => :phrase_counts
  validates_uniqueness_of :text
  
end
