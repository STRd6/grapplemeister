Player.Grappler = (I, self) ->
  Object.reverseMerge I,
    grapplingHooks: [0, 1].map (n) ->
      id: n
      grappleStart: null
      grappleDirection: null
      grappleAttached: null
      grappleLength: 0
      grappleRate: 1800

  hook = (n=0) ->
    I.grapplingHooks[n]

  hooks = ->
    I.grapplingHooks

  checkGrappleHits = (hook, elapsedTime) ->
    source = hook.grappleStart

    start = grapplePosition(hook)
    velocityLine = Line
      start: start
      end: start.add(hook.grappleDirection.scale(hook.grappleRate * elapsedTime))

    [nearestHit, line] = engine.lineCollision(velocityLine)
    if nearestHit
      hook.grappleAttached = nearestHit

  grapplePosition = (hook) ->
    hook.grappleAttached or
      hook.grappleStart.add(hook.grappleDirection.scale(hook.grappleLength))

  grappleTargetDirection = (hook) ->
    I.aimDirections[hook.id]

  grapple = (hook, elapsedTime) ->
    hook.grappleStart ||= self.position()
    hook.grappleDirection ||= grappleTargetDirection(hook) # TODO: Per hook
    hook.grappleLength += hook.grappleRate * elapsedTime

  ungrapple = (hook) ->
    hook.grappleStart = null
    hook.grappleDirection = null
    hook.grappleAttached = null
    hook.grappleLength = 0

  grappleDirection = (hook) ->
    if hook.grappleAttached
      hook.grappleAttached.subtract(self.position())
    else
      hook.grappleDirection

  self.bind 'afterTransform', (canvas) ->
    hooks().each (hook) ->
      if hook.grappleAttached
        canvas.drawLine
          color: "red"
          start: self.position()
          end: hook.grappleAttached

      else if hook.grappleDirection
        canvas.drawLine
          color: "white"
          start: self.position()
          end: hook.grappleStart.add(hook.grappleDirection.norm(hook.grappleLength))

  grapplePhysics: (elapsedTime) ->
    hooks().each (hook, i) ->
      if I.grappleTriggers[i]
        if hook.grappleAttached
          # Apply grappling hook force
          direction = grappleDirection(hook)

          # Elasticity
          length = Math.min(direction.length() / 40, 6)

          force = direction.norm(length * 1000)

          I.velocity.x += force.x * elapsedTime
          I.velocity.y += force.y * elapsedTime
        else
          grapple(hook, elapsedTime)
          checkGrappleHits(hook, elapsedTime)
      else
        ungrapple(hook)
