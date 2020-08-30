module TagCloud
  
  class TagInfo
    attr_reader :tag, :posts
    
    def initialize(tag)
      @tag = tag
      @posts = []
    end

    def push(post)
      @posts.push(post)
    end

    def canonize()
      TagInfo.canonize(@tag)
    end

    def self.canonize(tag)
      tag.downcase.gsub(/\s/, '-')
    end

    def sorted_posts()
      self.posts.sort { |a, b| b["date"] <=> a["date"] }
    end
  end

  class Tags
    include Enumerable
    
    def initialize()
      @tags = Hash.new
    end

    def push(tag, post)
      canonic_name = TagInfo.canonize(tag);
      if !@tags.has_key?(canonic_name)
        @tags[canonic_name] = TagInfo.new(tag)
      end

      @tags[canonic_name].push(post.data.slice("url", "title", "date", "tags"))
    end

    def each(&block)
      @tags.each(&block)
    end
  end
  
  class Generator < Jekyll::Generator

    safe true
    
    def generate(site)
      tags = Tags.new()
      for post in site.posts.docs
        for tag in post.data["tags"]
          tags.push(tag, post)
        end
      end

      tags.each do |key, value|
        site.pages << TagPage.new(site, site.source, value)
      end
    end
  end

  class TagPage < Jekyll::Page
    def initialize(site, base, tagInfo)
      self.content = ''
      self.data = data = { 'layout' => 'tag_page', 'posts' => tagInfo.sorted_posts, 'tag' => tagInfo.tag }
      
      super(site, base, '/tag/' + tagInfo.canonize(), 'index.html')
    end
    
    def read_yaml(*)
      # Do nothing
    end

  end

  module TagFilters
    def tag_link(obj)
      "<a href='/tag/#{TagInfo.canonize(obj)}'>#{obj}</a>"
    end
  end

  Liquid::Template.register_filter(TagCloud::TagFilters)
end
