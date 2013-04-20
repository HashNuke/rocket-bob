class ML.FirstPersonViewer

  constructor: (@world)->
    @delta = @world.clock.getDelta()
    @moveDistance = 2
    @rotationAngle = 0.05

  moveForward: ()->
    @world.camera.translateZ(-@moveDistance)

  moveBackward: ()->
    @world.camera.translateZ(@moveDistance)

  turnByAngle = (rotationAngle)->
    rotationMatrix = new THREE.Matrix4().makeRotationY(rotationAngle)
    @world.camera.matrix.multiply(rotationMatrix)
    @world.camera.rotation.setEulerFromRotationMatrix(@world.camera.matrix)

  turnLeft: ()->
    turnByAngle(@rotationAngle)

  turnRight: ()->
    turnByAngle(-@rotationAngle)

  #NOTE debugging-only
  levelUp: ()->
    @world.camera.translateY(@moveDistance)

  #NOTE debugging-only
  levelDown: ()->
    @world.camera.translateY(-@moveDistance)
