load 'tamagotchi.rb'

class Requst
  attr_accessor :method, :path, :tamagotchi

  def call(env)
    self.method = env['REQUEST_METHOD'].downcase
    self.path = env['REQUEST_PATH']
    self.tamagotchi ||= Tamagotchi.new
  end
end
