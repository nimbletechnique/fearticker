require 'open-uri'

class Page < ActiveRecord::Base
  
  has_many :phrase_counts
  
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
      :count => content.grep(/#{Regexp.quote(phrase)}/)
    })
  end
  
  def fetch
    open(url) { |f| f.read }
  end
  
  
end
