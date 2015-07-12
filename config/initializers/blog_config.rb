# Load blog config variables.

BLOG_CONFIG = YAML.load_file "#{Rails.root}/config/blog.yml"

AUTHOR = BLOG_CONFIG['author']
TIME_FORMAT = BLOG_CONFIG['time_format']
ARTICLE_FORMAT = BLOG_CONFIG['article_format']

DISQUS_SHORTNAME = BLOG_CONFIG[Rails.env]['disqus_shortname']

SYMBOLS = BLOG_CONFIG['symbols']
