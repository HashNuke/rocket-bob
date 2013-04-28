class ML.Player

  moveBy: 0.25
  grounded: false
  modelUrl: "/assets/rocket.dae"

  constructor: (@world) ->


  hasLanded: ()=>
    if @object.position.y < -35
      return true

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

  rotateLeft: () ->
    return if @grounded
    @object.rotation.z -= 0.1

  rotateRight: () ->
    return if @grounded
    @object.rotation.z += 0.1


  loadModel: (callback)->
    loader = new THREE.ColladaLoader()
    loader.options.convertUpAxis = true
    @callback = callback
    # @object = new ML.Voxel("red", 5)
    # @object.position = { x: 0, y: 100, z: 0 }

    loader.load @modelUrl, (collada)=>
      @object = collada.scene
      @object.scale.x = @object.scale.y = @object.scale.z = 0.05
      @object.position = { x: 0, y: 0, z: 0 }
      @object.updateMatrix()
      @callback()
