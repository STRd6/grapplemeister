Player.Physics = (I, self) ->
  maxWaterVelocity = 800
  waterFriction = 100

  gravity = Point(0, 3600)
  coefficientOfRestitution = 0.75

  PHYSICS =
    air: (dt) ->
      I.velocity.y += gravity.y * dt

    water: (dt) ->
      speed = Math.min(I.velocity.length(), maxWaterVelocity)
      speed -= waterFriction * dt

      I.velocity = I.velocity.clamp(Math.max(speed, 0))

  self.physics = (dt) ->
    if I.y <= waterLevel
      PHYSICS.air(dt)
    else
      PHYSICS.water(dt)

    # Collisions
    velocityLine = Line
      start: self.position()
      end: self.position().add(self.velocity().scale(dt))

    [nearestHit, line] = engine.lineCollision(velocityLine)

    if nearestHit
      normal = line.normal()
      projection = I.velocity.dot(normal)
      collisionResponse = normal.scale(-(1 + coefficientOfRestitution) * projection)
      I.velocity = I.velocity.add(collisionResponse)

    # TODO Come to a rest gently

  return {}
