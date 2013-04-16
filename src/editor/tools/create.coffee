Editor.Tool.Create = (I={}) ->
  clickStart = undefined

  I.name = "Create"

  wall = null

  # Snap point to nearby existing point if appropriate
  snapPoint = (point, snapDistance=20) ->
    existingPoints = wall.lines().invoke("endpoints").flatten()

    nearestPoint = existingPoints.minimum (existingPoint) ->
      point.distance(existingPoint)

    if nearestPoint and point.distance(nearestPoint) < snapDistance
      return nearestPoint.copy()

    return  point

  self = Editor.Tool(I).extend
    pressed: (worldPoint) ->
      clickStart = snapPoint(worldPoint)

    released: (worldPoint) ->
      if clickStart
        wall.addLine Line
          start: clickStart
          end: I.currentPosition

      clickStart = undefined

  self.on "updatePosition", (worldPoint) ->
    # TODO: Multiple walls
    wall = engine.first("Wall")

    I.currentPosition = snapPoint(worldPoint)

  self.on "draw", (canvas) ->
    if clickStart
      line = Line
        start: clickStart
        end: I.currentPosition

      canvas.drawLine Object.extend {}, line,
        color: "rgba(255, 0, 255, 0.75)"

    wall.trigger "afterTransform", canvas

  return self
