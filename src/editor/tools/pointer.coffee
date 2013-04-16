Editor.Tool.Pointer = (I={}) ->
  selectedObject = undefined
  initialObjectPosition = undefined
  startPoint = undefined

  I.name = "Pointer"

  self = Editor.Tool(I).extend
    pressed: (worldPoint) ->
      startPoint = worldPoint

    released: (worldPoint) ->
      startPoint = undefined

  self.on "draw", (canvas) ->

  self.on "updatePosition", (worldPoint) ->

  return self
