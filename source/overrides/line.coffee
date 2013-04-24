Line = (I={}) ->
  {start, end} = I

  __proto__: Line::
  start: start || Point.ZERO
  end: end || Point.ZERO

Line:: =
  slope: ->
    @end.subtract(@start)

  normal: ->
    slope = @slope()

    return Point(slope.y, -slope.x).norm()

  length: ->
    @start.distance(@end)

  endpoints: ->
    [@start, @end]

  intersects: (other) ->
    slope = @slope()
    otherSlope = other.slope()

    crossProduct = slope.cross(otherSlope)
    delta = @start.subtract(other.start)

    s = slope.cross(delta) / crossProduct
    t = otherSlope.cross(delta) / crossProduct

    if 0 <= s <= 1 and 0 <= t <= 1
      return Point.interpolate(@start, @end, t)

    return null
