class ML.Player

  moveBy:   0.25
  grounded: false
  modelUrl:      "/assets/spaceship.dae"
  movementStack: {x: 0, y: 0, z: 0}


  constructor: (@world) ->


  hasLanded: ()=>
    return true if @object.position.y < -35

    vector  = new THREE.Vector3(0, -1, 0)
    vector.sub(@object.position).normalize()
    raycaster  = new THREE.Raycaster(@object.position, vector)
    intersections = raycaster.intersectObjects(@world.scene.children)

    for intersection in intersections
      if intersection.distance < 5 && intersection.object.name == "debris"
        # TODO intersection with debris
        @grounded = true
        return true
    false


  updatePosition: =>
    @object.position =
     x: @object.position.x + @movementStack.x
     y: @object.position.y + @movementStack.y
     z: @object.position.z + @movementStack.z


  stopMovement: ()->
    @movementStack = {x: 0, y: 0, z: 0}


  moveRight: () ->
    return if @grounded
    @movementStack = {x: @moveBy, y: 0, z: 0}


  moveLeft: () ->
    return if @grounded
    @movementStack = {x: -@moveBy, y: 0, z: 0}


  moveForward: () ->
    return if @grounded
    @movementStack = {x: 0, y: 0, z: -@moveBy}

  moveBackward: () ->
    return if @grounded
    @movementStack = {x: 0, y: 0, z: @moveBy}

  rotateLeft: () ->
    return if @grounded
    @object.rotation.z -= 0.1

  rotateRight: () ->
    return if @grounded
    @object.rotation.z += 0.1


  loadModel: (callback)->
    loader = new THREE.ColladaLoader()
    loader.options.centerGeometry = true
    loader.options.convertUpAxis  = true
    @callback = callback

    loader.load @modelUrl, (model)=>
      @object = model.scene
      @object.scale.x = @object.scale.y = @object.scale.z = 0.5
      @object.position = { x: 0, y: 0, z: 0 }
      @object.updateMatrix()
      @callback()
