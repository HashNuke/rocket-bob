class ML.Player

  moveBy: 0.25
  grounded: false

  constructor: (@world) ->
    @object = new ML.Voxel("red", 5)
    @object.position = ({ x: 0, y: @world.secondPlatformHeight, z: 0 })
    @world.scene.add @object
    @


  hasLanded: ->
    vector  = new THREE.Vector3(0, -1, 0)
    vector.sub( @object.position ).normalize()
    raycaster  = new THREE.Raycaster( @object.position, vector )
    intersections = raycaster.intersectObjects( @world.scene.children )

    for intersection in intersections
      if intersection.distance < 3
        @grounded = true
        return true
    false


  moveRight: () ->
    return if @grounded
    @object.position.x += @moveBy


  moveLeft: () ->
    return if @grounded
    @object.position.x -= @moveBy


  moveForward: () ->
    return if @grounded
    @object.position.z -= @moveBy


  moveBackward: () ->
    return if @grounded
    @object.position.z += @moveBy
