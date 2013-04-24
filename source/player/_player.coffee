Player = (I={}) ->
  Object.reverseMerge I,
    controller: 0
    color: "#0A0"
    radius: 20

  self = GameObject(I)

  self.on "update", (elapsedTime) ->
    self.processInput(elapsedTime)
    self.grapplePhysics(elapsedTime)
    self.physics(elapsedTime)

  self.include "Debuggable"
  self.include "Player.Grappler"
  self.include "Player.Controller"
  self.include "Player.Input"
  self.include "Player.Physics"

  # self.debug
  #   filter: "changed"

  self
