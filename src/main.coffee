canvas = $("canvas").pixieCanvas()

Engine.defaultModules.push "Gamepads"

window.engine = Engine
  backgroundColor: "#FFF"
  canvas: canvas
  zSort: true
  FPS: 60

# engine.on "overlay", (canvas) ->
#   controller = engine.controller()
#   controller.drawDebug(canvas)

engine.include "Editor"

engine.start()
