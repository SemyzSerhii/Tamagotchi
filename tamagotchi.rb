class Tamagotchi
  attr_reader :health, :hungry, :happiness, :cleanliness

  STEP = 10
  MIN = 0
  MAX = 100

  def initialize
    self.health = 100
    self.hungry = 50
    self.happiness = 100
    self.cleanliness = 50
  end

  def feed
    self.hungry -= STEP
    self.health += STEP
    self.happiness += STEP

  end

  def clean
    self.cleanliness += STEP
    self.happiness += STEP

  end

  def fun
    self.happiness += STEP
    self.cleanliness -= STEP
    self.hungry += STEP
  end

  private

  def in_range(value)
    value = MIN if value < MIN
    value = MAX if value > MAX
    value
  end


  def health=(value)
    @health = in_range(value)
  end

  def hungry=(value)
    @hungry = in_range(value)
  end

  def happiness=(value)
    @happiness = in_range(value)
  end

  def cleanliness=(value)
    @cleanliness = in_range(value)
  end
end
