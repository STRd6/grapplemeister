Editor.Tool.Create = (I={}) ->
  clickStart = undefined

  I.name = "Create"

  lines = []

  self = Editor.Tool(I).extend
    pressed: (worldPoint) ->
      clickStart = worldPoint

    released: (worldPoint) ->
      if clickStart
        lines.push Line
          start: clickStart
          end: worldPoint

      clickStart = undefined

  self.on "draw", (canvas) ->
    if clickStart
      line = Line
        start: clickStart
        end: I.currentPosition

      canvas.drawLine Object.extend {}, line,
        color: "rgba(255, 0, 255, 0.75)"

    lines.each (line) ->
      canvas.drawLine Object.extend {}, line,
        color: "#00A"

  return self
