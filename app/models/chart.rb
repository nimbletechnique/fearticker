class Chart

  attr_accessor :categories
  
  def self.for_phrase_counts(phrase_counts)
    # create a hash of phrase > phrase_counts
    by_phrase = phrase_counts.inject({}) { |h,c| h[c.phrase] ||= []; h[c.phrase] << c; h}
    Chart.new.tap do |chart|
      by_phrase.each do |phrase, counts|
        points = counts.map { |count| Point.new(count.created_at, count.count) }
        chart.categories << Category.new(phrase.text, points)
      end
    end
  end
  
  def initialize(categories=[])
    @categories = categories
  end
  
  def to_img
    base = "http://chart.apis.google.com/chart"
    params = {}
    params[:cht] = "lc"
    params[:chs] = "400x200"
    params[:chl] = labels
    params[:chd] = "t:" + points
    params[:chco] = chart_colors
    params[:chdl] = chart_legend
    
    param_string = params.map { |k,v| "#{k}=#{v}" }.join("&amp;")
    url = base + "?" + param_string
    "<img src=\"#{url}\"/>"
  end

  private
  
  def colors 
    @colors ||= ["FF0000", "00FF00", "0000FF", "000000"]
  end
  
  def chart_legend
    categories.map { |category| category.name }.join("|")
  end
  
  def chart_colors
    categories.map { |category| colors[categories.index(category) % colors.length ] }.join(",")
  end
  
  def points
    categories.map { |category| category.points.map { |point| point.count }.join(",") }.join("|")
  end
  
  def labels
    categories.map { |category| category.name }.join("|")
  end
  
end

class Point
  attr_accessor :date, :count
  def initialize(date, count)
    @date = date
    @count = count
  end
end

class Category
  attr_accessor :name, :points
  def initialize(name, points=[])
    @name = name
    @points = points
  end
end