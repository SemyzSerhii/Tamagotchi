class Tamagotchi
  attr_reader :health, :hungre, :happy, :clean, :dead

  STEP = 10
  MIN = 0
  MAX = 100

  def initialize
    @health = 100
    @hungre = 50
    @happy = 100
    @clean = 50
    @dead = false
    dead?
  end

  def feed
    @hungre -= STEP
    @clean -= STEP
    @happy += STEP
    dead?
  end

  def clean
    @clean += STEP
    @happy += STEP
    dead?
  end

  def fun
    @happy += STEP
    @clean -= STEP
    @hungre += STEP
    dead?
  end

  private

  def in_rande(value)
    value = MIN if value < MIN
    value = MAX if value > MAX
    value
  end

  def dead?
    @health == 0
    @dead = true
  end

  def health=(value)
    @health = in_rande(value)
  end

  def hungre=(value)
    @hungre = in_rande(value)
  end

  def happy=(value)
    @happy = in_rande(value)
  end

  def clean=(value)
    @clean = in_rande(value)
  end
end
