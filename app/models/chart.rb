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
    params[:chs] = "600x200"
    
    # labels
    params[:chxt] = "x,y"
    params[:chxl] = "0:|" + x_axis_labels + "|1:|" + y_axis_labels
    
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
  
  def y_axis_labels
    category_points = categories.map { |c| c.points.map { |p| p.count }}.flatten.sort
    filter_by_factor_of(category_points, 4).join("|")
  end
  
  def x_axis_labels
    dates = categories.map { |c| c.points.map { |p| p.date }}.flatten.sort.map { |t| t.strftime "%m/%d/%Y" }
    filter_by_factor_of(dates, 4).join("|")
  end
  
  # filters down an enumeration into a evenly divided slice of items
  def filter_by_factor_of(enum, x)
    x -= 1
    result = []
    result << enum.first
    current = 1
    while current < x do
      current += 1
      result << enum[enum.length / x * current]
    end 
    result << enum.last
    result
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