# == Schema Information
# Schema version: 20081014141701
#
# Table name: contents
#
#  id         :integer         not null, primary key
#  permalink  :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Content < ActiveRecord::Base
  
  validates_presence_of :permalink
  validates_presence_of :body
  validates_uniqueness_of :permalink
  
  named_scope :ordered, :order => :permalink
  
end
