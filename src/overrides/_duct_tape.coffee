Array::maxima = (valueFunction=Function.identity) ->
  @inject([-Infinity, []], (memo, item) ->
    value = valueFunction(item)
    [maxValue, maxItems] = memo

    if value > maxValue
      [value, [item]]
    else if value is maxValue
      [value, maxItems.concat(item)]
    else
      memo
  ).last()

Array::maximum = (valueFunction) ->
  @maxima(valueFunction).first()

Array::minima = (valueFunction=Function.identity) ->
  inverseFn = (x) ->
    -valueFunction(x)

  @maxima(inverseFn)

Array::minimum = (valueFunction) ->
  @minima(valueFunction).first()
