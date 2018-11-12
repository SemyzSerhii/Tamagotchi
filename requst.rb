load 'tamagotchi.rb'
require 'erb'

class Requst
  attr_accessor :method, :path, :tamagotchi
  def call(env)
    self.method = env['REQUEST_METHOD'].downcase
    self.path = env['REQUEST_PATH']
    self.tamagotchi ||= Tamagotchi.new
    @request = Rack::Request.new(env)

    public_send(processed_methods_name)

    case path
    when '/tam' then Rack::Response.new(render('index.html.erb'))
    when '/'
    Rack::Response.new(render('name.html.erb')) do |i|
      i.set_cookie('a', @request.params['name'] )
      i.redirect('/tam')
    end
    end
    rescue NoMethodError
    Rack::Response.new('Not Found', 404)
  end

  def processed_methods_name
    @a = "#{method}#{path}".gsub('/', '_')
  end

  def get_
    @a.gsub(/_$*/, '/')
    tamagotchi
  end

  def get_feed
    @a.gsub(/_$*/, '/')
    tamagotchi.feed
  end

  def get_clean
    @a.gsub(/_$*/, '/')
    tamagotchi.clean
  end

  def get_sleep
    @a.gsub(/_$*/, '/')
    tamagotchi.sleep
  end

  def name
    @request.cookies['a'] || 'name'
  end
  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__ )
    ERB.new(File.read(path)).result(binding)
  end
end
