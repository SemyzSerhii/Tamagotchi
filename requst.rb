load 'tamagotchi.rb'
require 'erb'

class Requst
  attr_accessor :tamagotchi, :request, :view

  def call(env)
    self.request = Rack::Request.new(env)
    self.view = process_request

    Rack::Response.new(render('index.html.erb'), 200)
  end

  def process_request
    return '_dead_screen' if tamagotchi&.dead?

    case request.path
    when '/'
      new_screen
    when '/choice'
      tamagotchi.pet_name = request.params['name']
      '_pet_form'
    when '/game'
      tamagotchi.image = request.params['image_url']
      '_pet_actions'
    when '/feed'
      tamagotchi.feed
      '_pet_actions'
    when '/clean'
      tamagotchi.clean
      '_pet_actions'
    when '/sleep'
      tamagotchi.sleep
      '_pet_actions'
    else
      '_not_found'
    end
  rescue NoMethodError
    new_screen
  end

  def new_screen
    self.tamagotchi = Tamagotchi.new
    '_name_form'
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
end
