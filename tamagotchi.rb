class Tamagotchi
  STEP = 10
  MIN = 0
  MAX = 100

  attr_reader :health, :hungry, :energiness, :cleanliness
  attr_accessor :pet_name, :image

  def initialize
    self.health = MAX
    self.hungry = MAX / 2
    self.energiness = MAX
    self.cleanliness = MAX / 2
  end

  def feed
    self.hungry -= STEP
    self.health += STEP
    self.energiness += STEP
  end

  def clean
    self.cleanliness += STEP
    self.energiness -= STEP
    self.health -= STEP if energiness == MIN
  end

  def sleep
    self.energiness += STEP
    self.cleanliness -= STEP
    self.hungry += STEP
    self.health -= STEP if cleanliness == MIN
    self.health -= STEP if hungry == MAX
  end

  def dead?
    health.zero?
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

  def energiness=(value)
    @energiness = in_range(value)
  end

  def cleanliness=(value)
    @cleanliness = in_range(value)
  end
end
