class Article < Object
  attr_reader :title, :time, :path

  def initialize(title, time, path)
    @title = title
    @time = time
    @path = path
  end

  def to_partial_path
    'articles/article'
  end
end
