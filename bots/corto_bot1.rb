class CortoBot1 < RTanque::Bot::Brain
  NAME = 'corto_bot1'
  include RTanque::Bot::BrainHelper

  def tick!
    random_walk
    shoot
  end

  def random_walk
    command.heading = sensors.position.heading(random_position)
    command.speed = random_speed
  end

  def shoot
    command.turret_heading = target_angle
    command.fire(MIN_FIRE_POWER)
  end

  def random_position
    RTanque::Point.new(Random.rand(arena.width), Random.rand(arena.height), arena)
  end

  def random_speed
    Random.rand() * (MAX_BOT_SPEED - min_speed) + min_speed
  end

  def min_speed
    1
  end

  def target_angle
    RTanque::Heading.new_between_points(sensors.position, target)
  end

  def target
    farthest_corner
  end

  def farthest_corner
    max = { dist: 0 }
    corners.each do |corner|
      dist = RTanque::Point.distance(corner, sensors.position)
      if max[:dist] < dist
        max[:corner] = corner
        max[:dist] = dist
      end
    end
    max[:corner]
  end

  def corners
    [RTanque::Point.new(0, 0, arena),
     RTanque::Point.new(0, arena.height, arena),
     RTanque::Point.new(arena.width, 0, arena),
     RTanque::Point.new(arena.width, arena.height, arena)]
  end
end
