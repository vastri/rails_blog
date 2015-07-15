I built my first Ruby on Rails app in 2011 for a class project. Since then, I've used Ruby on Rails to build every web-based application I've created. Ruby on Rails is such a nice tool to quickly build web applications. It has evolved a lot since the first time I used it, only in a good way. This time, I decided to create a blog site with Ruby on Rails (because why not!), but in a slightly "unconventional" way: I chose not to create any ActiveModel object, and instead of storing the blog articles in a database, I would like to put them in the code, using the Markdown language.

### Basic Structure

I created a `articles/` folder under `app/assets/` to hold all the `.md` article files. And an `Article` class is created under `app/lib`, which contains information about an article, including the title, post time, and the source path. The `ArticlesController` object is created to control the articles' views. It has an `index` method to render all the `articles`, and a `show` method to render an individual `article`. In the `config/routes.rb` file, the `root` path matches to `articles#index`, and any other path matches to `articles#show`, which finds the `article` to render based on the path.

The `_article.html.erb` partial renders the `.md` article file based on the source path. And since Ruby on Rails expects the source path to be under `app/views/` folder for rendering, a symlink called `contents/` is created under `app/views/articles` which links to `app/assets/articles`, so that the `_article.html.erb` file can render the source file by following the symlink.

The `ArticlesController` generates an article title by calling `titleize` on the `.md` file's name. And the `.md` files' name format is `_article_title.html.md`, in order to be rendered as Markdown partials. However, since Ruby on Rails only allows alphanumeric characters and underscores in a partial file's name, an encoding mechanism is implemented to allow symbols in an article's title. And the decoding is handled by the `ArticlesController`. The `config/blog.yml` file, which is loaded by `config/initializers/blog_config.rb`, defines the encoding maps of the symbols. Other configuration variables pertaining the blog are also included in the `config/blog.yml` (e.g., blog author).

### Adding Disqus to the Blog

Disqus is a must-have feature for a blog site, and it's very easy to add it. I simply copied and pasted the following code to the end of `app/views/articles/show.html.erb` to enable the Disqus commenting functionality.

<pre class="prettyprint">&lt;div id="disqus_thread">&lt;/div>
&lt;script type="text/javascript">
    /* * * CONFIGURATION VARIABLES * * */
    // Required: on line below, replace text in quotes with your forum shortname
    var disqus_shortname = 'FORUM SHORTNAME GOES HERE';

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
&lt;/script>
&lt;noscript>Please enable JavaScript to view the &lt;a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.&lt;/a>&lt;/noscript>
</pre>

### Deploying on AWS

Finally, it's time to deploy the site! I'm using AWS Elastic Beanstalk to deploy my blog site. AWS Elastic Beanstalk is a very easy-to-use tool for deploying and scaling web applications. You can simply upload the code and it automatically uses Amazon's powerful cloud services to handle the deployment, from capacity provisioning, load balancing, auto-scaling to application health monitoring.

After installing the EB CLI, all I did was `eb create blog_env` to create a new Elastic Beanstalk environment from the Ruby on Rails app I created. And since a Ruby on Rails app running in production needs a `SECRET_KEY_BASE` environment variable, I could set this variable by simply running `eb setenv SECRET_KEY_BASE=<secret key base>`. After that, a simple `eb deploy` would pick up my code and deploy the app on AWS. And here it is! My blog site is up and running!

(Click [here](https://github.com/vastri/rails_blog) to see the source code)
