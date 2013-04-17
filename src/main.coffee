canvas = $("canvas").pixieCanvas()

Engine.defaultModules.push "Gamepads"

window.waterLevel = App.height

window.Arena =
  width: App.width * 2
  height: App.height * 1.5

window.engine = Engine
  backgroundColor: "#FFF"
  canvas: canvas
  FPS: 60

# engine.on "overlay", (canvas) ->
#   canvas.withTransform Matrix.translation(200, 0), ->
#     controller = engine.controller()
#     controller.drawDebug(canvas)

engine.include "Editor"

boundaryLines = [
  Point(0, 0),
  Point(Arena.width, 0),
  Point(Arena.width, Arena.height),
  Point(0, Arena.height)
].map (p, i, a) ->
  Line
    start: p
    end: a.wrap(i + 1)

engine.add "Wall",
  lines: boundaryLines

engine.add "CameraTarget"

engine.on "draw", (canvas) ->
  canvas.withTransform engine.camera().transform(), (canvas) ->
    canvas.drawRect
      x: 0
      y: waterLevel
      width: Arena.width
      height: Arena.height - waterLevel
      color: "rgba(0, 0, 255, 0.5)"

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
