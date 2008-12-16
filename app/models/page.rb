# == Schema Information
# Schema version: 20081014141701
#
# Table name: pages
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  position   :integer
#

class Page < ActiveRecord::Base

  named_scope :all, {}
  named_scope :ordered, :order => "position"
  named_scope :including_phrases, :include => [:phrases, :phrase_counts]
  
  has_many :phrase_counts, :dependent => :destroy
  has_many :phrases, :through => :phrase_counts
  
  validates_presence_of :url

  def self.expire(page_id)
    cache_dir = ActionController::Base.page_cache_directory
    FileUtils.rm_r(Dir.glob(cache_dir+"/pages/#{page_id}.*")) rescue Errno::ENOENT
  end
  
  def self.count_all
    Page.all.each do |page|
      page.count Phrase.all.map { |phrase| phrase.text }
    end
  end

  def find_counts(start_date)
    counts = PhraseCount.find(:all, {
      :select => "phrase_counts.*, date(phrase_counts.created_at) as date",
      :include => :phrase,
      :conditions => ["phrase_counts.page_id = ? AND phrase_counts.created_at >= ?", id, start_date.beginning_of_day],
      :order => "created_at"
    })
    counts.inject({}) do |hash, phrase_count|
      phrase_hash = hash[phrase_count.phrase.text] ||= {}
      date_hash = phrase_hash[phrase_count.date] ||= { :count => 0, :number_counts => 0}
      date_hash[:count] += phrase_count.count
      date_hash[:number_counts] += 1
      hash
    end
  end

  def count(*phrases)
    content = fetch
    phrases.flatten.each do |phrase|
      count_phrase content, phrase
    end
  end
   
  private

  
  
  def count_phrase(content, phrase)
    phrase_counts.create({
      :phrase => Phrase.find_or_create_by_text(phrase),
      :count => content.grep(/#{Regexp.quote(phrase)}/i).length
    })
  end
  
  def fetch
    open(url) { |f| f.read }
  end
  
  
end
