Wall = (I={}) ->
  Object.reverseMerge I,
    lines: []
    color: "#000"

  self = GameObject(I).extend
    addLine: (line) ->
      I.lines.push line

  self.attrReader "lines"

  self.unbind ".Drawable"
  # Lines are stored in world-space, so no need to apply our own transform
  self.on "afterTransform", (canvas) ->
    I.lines.each (line) ->
      canvas.drawLine Object.extend {}, line,
        color: I.color

  return self
