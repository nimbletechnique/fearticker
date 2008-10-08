class Page < ActiveRecord::Base

  named_scope :all, {}
  named_scope :ordered, :order => "url"
  
  has_many :phrase_counts, :dependent => :destroy
  has_many :phrases, :through => :phrase_counts
  
  validates_presence_of :url
  
  def self.count_all
    Page.all.each do |page|
      page.count Phrase.all.map { |phrase| phrase.text }
    end
  end
  
  def count(*phrases)
    content = fetch
    phrases.flatten.each do |phrase|
     count_phrase content, phrase 
    end
  end
  
  def counts_since(phrase, since)
    phrase_counts.for_phrase(phrase).in_range(since, Time.now.utc).ordered
  end
  
  def average_count_for_since(phrase, since) 
    phrase_counts.for_phrase(phrase).in_range(since, Time.now.utc).average("phrase_counts.count")
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
