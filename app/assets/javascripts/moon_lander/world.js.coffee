class ML.World
  opts:
    width:  if window? then window.innerWidth  else 640
    height: if window? then window.innerHeight else 480

  cameraOffsets: {x: 0, y: 5, z: 10}

  rendererType: "webgl"

  constructor: (@holder, @rendererType, @stats)->

    @opts.width = $(@holder).width()

    @scene = new THREE.Scene()
    @clock = new THREE.Clock()
    @addPlayer(@onPlayerLoad)


  onPlayerLoad: =>
      @setupRenderer()
      @setupCamera()
      @setupListeners()

      new ML.Terrain(@)
      $(@holder).append @renderer.domElement

      directionalLight1 = new THREE.DirectionalLight( 0xFFFFFF, 1 )
      directionalLight1.position.set( 0.5, 1, 0.5 )
      @scene.add directionalLight1
      directionalLight2 = new THREE.DirectionalLight( 0xFFFFFF, 1 )
      directionalLight2.position.set( -0.5, -1, -0.5 )
      @scene.add directionalLight2

      @scene.add @player.object
      @render()


  addPlayer: (callback)=>
    @player = new ML.Player(@)
    @player.loadModel(callback)
    @


  setupListeners: =>
    @viewer = new ML.FirstPersonViewer(@)
    @controls = new ML.KeyboardControls(@)

    orientationCallback = (event)=>
      a = event.alpha
      b = event.beta
      g = event.gamma
      # console.log a, b, g

      # if @player.object
      #   # @player.object.rotation.z = -2.0 * g
      #   # # @player.object.rotation.x = -2.0 * b

    window.addEventListener 'deviceorientation', orientationCallback, false
    $(window).on("resize", @windowResizeHandler)



  windowResizeHandler: =>
    @camera.aspect = $(@holder).width() / window.innerHeight
    @camera.updateProjectionMatrix()
    @renderer.setSize($(@holder).width(), window.innerHeight)


  render: ()=>
    @renderer.render @scene, @camera
    @camera.position =
      x: @player.object.position.x + @cameraOffsets["x"]
      y: @player.object.position.y + @cameraOffsets["y"]
      z: @player.object.position.z + @cameraOffsets["z"]

    @camera.lookAt(@player.object.position)
    window.requestAnimationFrame(@render)
    @stats.update()
    @


  setupRenderer: ->
    if @rendererType == "webgl"
      @renderer = new THREE.WebGLRenderer()
    else
      @renderer = new THREE.CanvasRenderer({antialias: true})

    @renderer.setSize @opts.width, @opts.height
    @renderer.setClearColorHex 0x333333, 1.0
    @renderer.clear()
    @


  setupCamera: =>
    @camera = new THREE.PerspectiveCamera(60, (@opts.width / @opts.height), 1, 20000)

    @
