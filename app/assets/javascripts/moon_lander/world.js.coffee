class ML.World
  opts:
    width:  if window? then window.innerWidth  else 640
    height: if window? then window.innerHeight else 480

  rendererType: "webgl"

  constructor: (@holder, @rendererType, @stats)->
    @opts.width = $(@holder).width()

    @scene = new THREE.Scene()
    @clock = new THREE.Clock()

    @addPlayer()
    @setupRenderer()
    @setupCamera()
    @setupListeners()

    terrain = new ML.Terrain(@)

    $(@holder).append @renderer.domElement


  addPlayer: ()->
    @player = new ML.Player(@)
    @

  setupListeners: ->
    @viewer = new ML.FirstPersonViewer(@)
    @controls = new ML.KeyboardControls(@)

    $(window).on("resize", @windowResizeHandler)

    $("body").on "click", "canvas", (e)=>
      @projector = new THREE.Projector()
      mouseX = +(e.clientX / window.innerWidth ) * 2 - 1
      mouseY = -(e.clientY / window.innerHeight) * 2 + 1

      vector  = new THREE.Vector3( mouseX, mouseY, 1 )
      @projector.unprojectVector( vector, @camera )

      vector.sub( @camera.position ).normalize()
      raycaster  = new THREE.Raycaster( @camera.position, vector )
      intersects = raycaster.intersectObjects( @scene.children )

      return if intersects.length == 0

      intersect = intersects[0]
      object3d  = intersect.object
      console.log "You've hit #{object3d.name}"
      # objectCtx = this._objectCtxGet(object3d)
      # if( !objectCtx )  return




  windowResizeHandler: =>
    @camera.aspect = $(@holder).width() / window.innerHeight
    @camera.updateProjectionMatrix()
    @renderer.setSize($(@holder).width(), window.innerHeight)



  render: ()=>
    @renderer.render @scene, @camera
    @player.object.position.y -= 0.25 if !@player.hasLanded()
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
    @renderer.setClearColorHex 0x222222, 1.0
    @renderer.clear()
    @


  setupCamera: ->
    @camera = new THREE.PerspectiveCamera(60, (@opts.width /@opts.height), 1, 20000)
    @camera.position = {x: 0, y: @player.object.position.y + 5, z: 67}
    @camera.lookAt({x: 0, y:0, z:0})
    @


  updateScene: ()->
    @camera.lookAt(@player.object.position)