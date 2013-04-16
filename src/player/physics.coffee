Player.Physics = (I, self) ->
  VELOCITY_MAX_X = 500

  gravity = Point(0, 3600)
  coefficientOfRestitution = 0.75

  PHYSICS =
    air: (dt) ->
      I.velocity.y += gravity.y * dt

      # I.velocity.x = I.velocity.x.clamp(-VELOCITY_MAX_X, VELOCITY_MAX_X)

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

  self.physics = PHYSICS.air

  return {}
