class CortoBot1 < RTanque::Bot::Brain
  NAME = 'corto_bot1'
  include RTanque::Bot::BrainHelper

  def tick!
    self.random_walk
    ## main logic goes here

    # use self.sensors to detect things
    # See http://rubydoc.info/github/awilliams/RTanque/master/RTanque/Bot/Sensors

    # use self.command to control tank
    # See http://rubydoc.info/github/awilliams/RTanque/master/RTanque/Bot/Command

    # self.arena contains the dimensions of the arena
    # See http://rubydoc.info/github/awilliams/RTanque/master/frames/RTanque/Arena
  end

  def random_walk
    command.heading = self.sensors.position.heading(RTanque::Point.new(*random_position, self.arena))
    command.speed = random_speed
  end

  def random_position
    [Random.rand(self.arena.width), Random.rand(self.arena.height)]
  end

  def random_speed
    Random.rand() * (MAX_BOT_SPEED - min_speed) + min_speed
  end

  def min_speed
    1
  end
end
