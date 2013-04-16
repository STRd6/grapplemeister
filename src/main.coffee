canvas = $("canvas").pixieCanvas()

Engine.defaultModules.push "Gamepads"

window.engine = Engine
  backgroundColor: "#FFF"
  canvas: canvas
  zSort: true
  FPS: 60

engine.on "overlay", (canvas) ->
  canvas.withTransform Matrix.translation(200, 0), ->
    controller = engine.controller()
    controller.drawDebug(canvas)

engine.include "Editor"

boundaryLines = [
  Point(0, 0),
  Point(App.width, 0),
  Point(App.width, App.height),
  Point(0, App.height)
].map (p, i, a) ->
  Line
    start: p
    end: a.wrap(i + 1)

engine.add "Wall",
  lines: boundaryLines

engine.lineCollision = (line) ->
  # TODO: All walls
  if wall = engine.first("Wall")
    hits = wall.lines().map (wallLine) ->
      [line.intersects(wallLine), wallLine]
    .select ([collision, wallLine]) ->
      collision

    nearestHit = hits.minimum ([point, wallLine]) ->
      line.start.distance(point)

    if nearestHit
      return nearestHit

  return []

engine.add "Player",
  x: App.width/2
  y: App.height/2

engine.start()
