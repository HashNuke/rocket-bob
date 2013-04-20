class ML.KeyboardControls

  constructor: (@world)->
    @registerEvents()


  registerEvents: ()=>

    $("body").keypress (e)=>
      if e.keyCode == 119 # up-w
        @world.player.moveForward()

      else if e.keyCode == 115  # down-s
        @world.player.moveBackward()
      
      else if e.keyCode == 97   # left-a
        @world.player.moveLeft()

      else if e.keyCode == 100  # right-d
        @world.player.moveRight()

