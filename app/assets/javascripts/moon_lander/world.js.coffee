class ML.World
  opts:
    width:  if window? then window.innerWidth  else 640
    height: if window? then window.innerHeight else 480

  basePlatformHeight:   -50
  secondPlatformHeight: 100

  rendererType: "webgl"

  constructor: (@holder, @rendererType, @player, @stats)->
    @midSector1 = [
      @secondPlatformHeight - (2 * (@secondPlatformHeight + Math.abs(@basePlatformHeight))/6),
      @secondPlatformHeight - (3 * (@secondPlatformHeight + Math.abs(@basePlatformHeight))/6)
    ]

    @midSector2 = [
      @secondPlatformHeight - (3 * (@secondPlatformHeight + Math.abs(@basePlatformHeight))/6),
      @secondPlatformHeight - (4 * (@secondPlatformHeight + Math.abs(@basePlatformHeight))/6)
    ]

    @opts.width = $(@holder).width()

    @scene = new THREE.Scene()
    @clock = new THREE.Clock()

    @setupRenderer()
    @setupCamera()
    @setupListeners()

    new ML.Terrain(@)
    $(@holder).append @renderer.domElement
    @scene.add @player.object


  addPlayer: ()->
    @player = new ML.Player(@)
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

    if !@player.hasLanded(@)
      @player.object.position.y -= 0.25
      if @player.object.position.y > @midSector1[0] && @player.object.position.y > @midSector1[1]
        @camera.position.z -= 0.25
      if @player.object.position.y > @midSector2[0] && @player.object.position.y > @midSector2[1]
        @camera.position.z += 0.25
    else
      $(".viewer").empty()
      $(".intro").show()
      if @player.object.rotation.z > -7 && @player.object.rotation.z < 7
        $(".won").show()
        $(".lost").hide()
      else
        $(".lost").show()
        $(".won").hide()

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
    @renderer.setClearColorHex 0x220044, 1.0
    @renderer.clear()
    @


  setupCamera: =>
    @camera = new THREE.PerspectiveCamera(60, (@opts.width /@opts.height), 1, 20000)
    @camera.position = {x: 0, y: 5, z: 20}
    @camera.lookAt(@player.object.position)
    @


  updateScene: ()->
    @camera.lookAt(@player.object.position)
