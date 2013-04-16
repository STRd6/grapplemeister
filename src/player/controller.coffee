Player.Controller = (I, self) ->

  controller: ->
    engine.controller(I.controller)

  triggerPosition: (n=0) ->
    button = ["LT", "RT"][n]

    self.controller().buttonDown button

  controllerPosition: (stick=0) ->
    self.controller().position(stick)
