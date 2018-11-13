load 'tamagotchi.rb'
require 'erb'

class Requst
  attr_accessor  :tamagotchi
  def call(env)

    self.tamagotchi ||= Tamagotchi.new
    @request = Rack::Request.new(env)

    case @request.path
    when '/'
    Rack::Response.new(render('name.html.erb')) do |i|
      i.set_cookie('a', @request.params['name'] )
    end
    when '/tam' then Rack::Response.new(render('index.html.erb')) do
      tamagotchi
    end
    when '/feed' then Rack::Response.new(render('index.html.erb')) do
      tamagotchi.feed
    end
    when '/clean' then Rack::Response.new(render('index.html.erb')) do
      tamagotchi.clean
    end
    when '/sleep' then Rack::Response.new(render('index.html.erb')) do
      tamagotchi.sleep
    end
    end
    rescue NoMethodError
    Rack::Response.new('Not Found', 404)
  end

  def name_pet
    @request.cookies['a'] || 'name'
  end
  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__ )
    ERB.new(File.read(path)).result(binding)
  end
end
