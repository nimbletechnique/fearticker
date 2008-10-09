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
    delete_empty_categories
    sort_categories
    
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
  
  def sort_categories
    @categories.sort! { |ca, cb| cb.average_count <=> ca.average_count }
  end
  
  def delete_empty_categories
    @categories.delete_if { |c| c.points.all? { |p| p.count == 0 }}
  end
  
  def colors 
    @colors ||= ["FF0000", "00FF00", "0000FF", "000000", "F0F3B4", "F1238D"]
  end
  
  def chart_legend
    categories.map { |category| "#{category.name} (#{sprintf("%0.2f",category.average_count)} avg)" }.join("|")
  end
  
  def chart_colors
    categories.map { |category| colors[categories.index(category) % colors.length ] }.join(",")
  end
  
  def points
    categories.map { |category| normalized_counts(category).join(",") }.join("|")
  end
  
  # the points here must be defined between 1 and 100
  # for each point, it becomes (point / max * 100 *).to_i
  def normalized_counts(category)
    counts = categories.map { |c| c.points }.flatten.map { |point| point.count }
    max = counts.max
    category.points.map { |p| p.count }.map { |count| max == 0 ? 0 : (count.to_f / max * 100).to_i }
  end
  
  def y_axis_labels
    how_many = 5
    category_points = categories.map { |c| c.points.map { |p| p.count }}.flatten.sort
    min = category_points.min
    max = category_points.max
    [min, max].join("|")
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
  
  def total_count
    points.map { |p| p.count }.inject { |sum, count| sum + count }
  end
  
  def average_count
    total_count.to_f / points.length
  end
  
end